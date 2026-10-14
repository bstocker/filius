# Atelier Filius — Simulation de réseau

Cet atelier fait découvrir le fonctionnement d'un réseau informatique (adresses IP et MAC, switch,
routeur, routage, protocoles SMTP/POP3, couches TCP/IP) à l'aide du simulateur
[Filius](https://www.lernsoftware-filius.de/), lancé dans une session Linux Kali depuis GitHub Codespaces.

**Déroulé :**

1. [Lancer l'environnement](#1-lancer-lenvironnement)
2. [Installer Filius](#2-installer-filius)
3. [Exercice d'échauffement](#3-exercice-déchauffement)
4. [L'atelier Filius](#4-latelier-filius)
5. [Dépannage](#5-dépannage)

## Contenu du dépôt

```
.
├── README.md                    ← vous êtes ici
├── docs/
│   └── Atelier_Filius.pdf       ← énoncé de l'atelier (5 exercices)
├── exercice4_ressources.fls     ← réseau de départ de l'exercice 4
└── scripts/
    └── install_filius.sh        ← installation de Filius dans la session Kali
```

---

## 1. Lancer l'environnement

1. Faire un **fork** de ce dépôt (bouton *Fork* en haut à droite).
2. Sur votre fork : **Code → Codespaces → Create codespace on main**.
3. Dans le terminal du Codespace, coller la ligne suivante :

   ```bash
   docker run --rm -it --shm-size=512m --user root -p 6901:6901 -e VNC_PW=password kasmweb/core-kali-rolling:1.17.0
   ```

4. Quand le démarrage est terminé (quelques minutes), ouvrir l'onglet **PORTS** du Codespace puis
   ouvrir le port **6901** (attention aux bloqueurs de popup).
5. La fenêtre affiche une erreur **502 Bad Gateway** : c'est normal. Ajouter `https://` devant
   l'URL dans la barre d'adresse. Le navigateur signale un site non sécurisé, mais il est sans danger.
6. Se connecter avec l'utilisateur `kasm_user` et le mot de passe `password`.

## 2. Installer Filius

Dans le **Terminal** de la session Linux Kali, passer en root :

```bash
su
```

Puis lancer le script d'installation :

```bash
curl -fsSL https://raw.githubusercontent.com/bstocker/filius/main/scripts/install_filius.sh | bash
```

<details>
<summary>Installation manuelle (si le script ne fonctionne pas)</summary>

```bash
curl -L -O "https://www.lernsoftware-filius.de/downloads/Setup/filius_2.9.4_all.deb"

apt-get install -y gnupg curl ca-certificates

mkdir -p /etc/apt/keyrings
curl -fsSL https://archive.kali.org/archive-key.asc | gpg --dearmor -o /etc/apt/keyrings/kali-archive-keyring.gpg
chmod 644 /etc/apt/keyrings/kali-archive-keyring.gpg

cat > /etc/apt/sources.list <<'EOF'
deb [signed-by=/etc/apt/keyrings/kali-archive-keyring.gpg] http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware
EOF

apt update
apt install -y default-jre git
apt install ./filius_2.9.4_all.deb
```

Répondre `Y` si une confirmation est demandée.

</details>

Une fois l'installation terminée, cliquer sur **Applications** (icône en haut à gauche de la
session Linux) puis lancer **Filius** depuis *All Applications* (ou rechercher « Filius » puis *Run*).

> ⚠️ Choisir la langue (**Français**) lors de la première ouverture du logiciel.

📸 **Travail demandé :** capture d'écran de votre Filius dans le canal *général* du Discord.

## 3. Exercice d'échauffement

Vidéo d'introduction à Filius : https://youtu.be/nzuRSOwdF5I

1. Créer un réseau de 4 machines : **M1**, **M2**, **M3** et **M4**.
2. L'adresse IP de **M1** est `192.168.1.1`, masque `255.255.255.0`. Choisir les adresses IP de M2, M3 et M4.
3. Effectuer un `ping` de la machine **M2** vers la machine **M4**.

📸 **Travail demandé :** capture d'écran de votre Filius dans le canal *général* du Discord.

## 4. L'atelier Filius

L'énoncé complet est dans **[docs/Atelier_Filius.pdf](docs/Atelier_Filius.pdf)**.

| Partie | Exercice | Thème | Fichier à enregistrer | Pages |
|---|---|---|---|---|
| 1. Réseau local | 1 | Connexion pair à pair de deux machines | `exercice1.fls` | 1–3 |
| 2. Interconnexion de réseaux | 2 | Plusieurs machines avec un switch | `exercice2.fls` | 3 |
| | 3 | Deux réseaux reliés par un routeur | `exercice3.fls` | 3–5 |
| | 4 | Routage, `traceroute`, simulation de panne | *(fourni)* `exercice4_ressources.fls` | 5–6 |
| 3. Serveur applicatif | 5 | Serveur de messagerie (SMTP / POP3) | `exercice5.fls` | 6–10 |

> 💡 En mode *simulation*, régler la vitesse sur **10 % ou 20 %** pour bien voir le trajet des données.

### Récupérer le fichier de l'exercice 4

Dans le terminal de la session Linux Kali :

```bash
cd ~
git clone https://github.com/bstocker/filius
```

Puis dans Filius : **Ouvrir** → dossier `filius` de votre répertoire personnel → `exercice4_ressources.fls`.

## 5. Dépannage

| Problème | Solution |
|---|---|
| Le port 6901 ne s'ouvre pas | Autoriser les popups pour `github.dev` / `app.github.dev`. |
| Erreur **502 Bad Gateway** | Ajouter `https://` devant l'URL du port 6901. |
| Le script s'arrête sur « doit être lancé en root » | Taper `su` puis relancer la commande `curl … \| bash`. |
| Filius n'apparaît pas dans *Applications* | Fermer puis rouvrir le menu *Applications*, ou rechercher « Filius ». |
| Le `ping` échoue entre deux réseaux | Vérifier la **passerelle** de chaque machine (exercice 3, question 6). |
| La session Kali a disparu | Le conteneur est supprimé quand le terminal du Codespace est fermé (`--rm`) : relancer l'étape 1 puis 2. |
