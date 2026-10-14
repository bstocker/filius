Faire un fork de ce repository

Lancer Codespace


Coller la ligne suivant dans le terminal
docker run --rm -it --shm-size=512m --user root -p 6901:6901 -e VNC_PW=password kasmweb/core-kali-rolling:1.17.0

Lorsque l'installation est terminée (après quelques minutes), cliquez sur le bouton [PORTS] du Codespace puis tapez 6901 (attention aux bloqueurs de popup). Important : Vous recevrez un message d'erreur à l'ouverture de la fenêtre (502 Bad Gateway), vous devrez alors mettre https:// devant l'URL dans la fenêtre qui vient de s'ouvrir. Le site n'est pas sécurisé mais il est sans danger.


Dans le "Terminal" de votre session Linux Kali copier/coller les lignes de codes suivantes :
su

curl -L -O "https://www.lernsoftware-filius.de/downloads/Setup/filius_2.9.4_all.deb"

apt-get install -y gnupg curl ca-certificates

mkdir -p /etc/apt/keyrings
curl -fsSL https://archive.kali.org/archive-key.asc | gpg --dearmor -o /etc/apt/keyrings/kali-archive-keyring.gpg
chmod 644 /etc/apt/keyrings/kali-archive-keyring.gpg

cat > /etc/apt/sources.list <<'EOF'
deb [signed-by=/etc/apt/keyrings/kali-archive-keyring.gpg] http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware
EOF

apt update

apt install -y default-jre

apt install ./filius_2.9.4_all.deb


Dites Yes : Y

Une fois l'installation terminée, cliquez sur Applications (icone en haut à gauche de votre session Linux) puis lancer Filius qui est disponible dans "All Applications". Ou faire une recherche de Filius puis Run.

Attention : Choisir la langue lors de la première ouverture du logiciel.

----------------------------------
Travail demandé Capture d'écran de votre Filius dans le canal général de ce Discord.

----------------------------------
-----------------
Exercice Filius :
------------------
Vidéo d'introduction Filius : https://youtu.be/nzuRSOwdF5I

Créez un réseau de 4 machines (M1, M2, M3 et M4). L'adresse IP de la machine M1 est "192.168.1.1 masque 255.255.255.0", choisissez les adresses IP des machines M2, M3 et M4.

Effectuez un "ping" de la machine M2 vers la machine M4.

Travail demandé Capture d'écran de votre Filius dans le canal général de ce Discord.

-----------------
Atelier Filius :
-----------------
Vous pouvez à présent travailler sur l'atelier Filius ci-dessous.

Atelier_Filius.pdf










