#!/usr/bin/env bash
# Installe Filius (et Java) dans la session Linux Kali de l'atelier.
# A lancer en root : taper d'abord `su` dans le terminal Kali.
set -euo pipefail

# Version utilisée si la détection de la dernière version échoue.
FILIUS_FALLBACK_VERSION="2.14.0"
FILIUS_DOWNLOAD_PAGE="https://www.lernsoftware-filius.de/Herunterladen"

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

# Le site ne garde que la dernière version : on la lit sur la page de téléchargement.
FILIUS_VERSION="$(curl -fsSL "$FILIUS_DOWNLOAD_PAGE" | grep -oE 'filius_[0-9.]+_all\.deb' | head -n 1 | sed -E 's/filius_(.*)_all\.deb/\1/' || true)"
FILIUS_VERSION="${FILIUS_VERSION:-$FILIUS_FALLBACK_VERSION}"
FILIUS_DEB="filius_${FILIUS_VERSION}_all.deb"

echo "==> Téléchargement et installation de Filius ${FILIUS_VERSION}"
curl -fL -o "/tmp/${FILIUS_DEB}" "https://www.lernsoftware-filius.de/downloads/Setup/${FILIUS_DEB}"
apt-get install -y "/tmp/${FILIUS_DEB}"
rm -f "/tmp/${FILIUS_DEB}"

echo
echo "Filius est installé. Lancez-le depuis Applications > All Applications > Filius."
