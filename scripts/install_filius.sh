#!/usr/bin/env bash
# Installe Filius (et Java) dans la session Linux Kali de l'atelier.
# A lancer en root : taper d'abord `su` dans le terminal Kali.
set -euo pipefail

FILIUS_VERSION="2.9.4"
FILIUS_DEB="filius_${FILIUS_VERSION}_all.deb"

if [ "$(id -u)" -ne 0 ]; then
  echo "Ce script doit être lancé en root : tapez d'abord 'su' puis relancez-le." >&2
  exit 1
fi

echo "==> Mise à jour de la clé du dépôt Kali"
apt-get install -y gnupg curl ca-certificates
mkdir -p /etc/apt/keyrings
curl -fsSL https://archive.kali.org/archive-key.asc | gpg --dearmor --yes -o /etc/apt/keyrings/kali-archive-keyring.gpg
chmod 644 /etc/apt/keyrings/kali-archive-keyring.gpg

cat > /etc/apt/sources.list <<'EOF'
deb [signed-by=/etc/apt/keyrings/kali-archive-keyring.gpg] http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware
EOF

echo "==> Installation de Java et git"
apt-get update
apt-get install -y default-jre git

echo "==> Téléchargement et installation de Filius ${FILIUS_VERSION}"
curl -fL -o "/tmp/${FILIUS_DEB}" "https://www.lernsoftware-filius.de/downloads/Setup/${FILIUS_DEB}"
apt-get install -y "/tmp/${FILIUS_DEB}"
rm -f "/tmp/${FILIUS_DEB}"

echo
echo "Filius est installé. Lancez-le depuis Applications > All Applications > Filius."
