#!/usr/bin/env bash
# Démarre la session Linux Kali (KasmVNC) dans le Codespace et la rend accessible
# depuis le navigateur.
#
# Kasm ne répond qu'en HTTPS sur le port 6901, alors que Codespaces transmet les
# connexions en HTTP (d'où l'erreur 502). Un relais socat écoute donc en HTTP sur
# le port 6080 et transmet au port 6901 en HTTPS.
set -euo pipefail

CONTAINER="kali"
IMAGE="kasmweb/core-kali-rolling:1.17.0"
KASM_PORT=6901
WEB_PORT=6080
PASSWORD="password"

if ! command -v socat >/dev/null; then
  echo "==> Installation de socat"
  sudo apt-get update -qq && sudo apt-get install -y -qq socat
fi

if docker ps --format '{{.Names}}' | grep -qx "$CONTAINER"; then
  echo "==> La session Kali est déjà démarrée"
else
  echo "==> Démarrage de la session Kali (le premier lancement prend quelques minutes)"
  docker run -d --rm --name "$CONTAINER" --shm-size=512m --user root \
    -p "$KASM_PORT:$KASM_PORT" -e VNC_PW="$PASSWORD" "$IMAGE" >/dev/null
fi

echo "==> Attente du démarrage de Kasm"
until curl -sk -o /dev/null "https://127.0.0.1:$KASM_PORT"; do
  if ! docker ps --format '{{.Names}}' | grep -qx "$CONTAINER"; then
    echo "Le conteneur Kali s'est arrêté. Journal : docker logs $CONTAINER" >&2
    exit 1
  fi
  sleep 2
done

if ! pgrep -f "socat TCP-LISTEN:$WEB_PORT" >/dev/null; then
  nohup socat "TCP-LISTEN:$WEB_PORT,fork,reuseaddr" "OPENSSL:127.0.0.1:$KASM_PORT,verify=0" \
    >/dev/null 2>&1 &
fi

if [ -n "${CODESPACE_NAME:-}" ]; then
  URL="https://$CODESPACE_NAME-$WEB_PORT.$GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN"
else
  URL="http://localhost:$WEB_PORT"
fi

echo
echo "Session Kali prête : $URL"
echo "Identifiant : kasm_user   Mot de passe : $PASSWORD"
