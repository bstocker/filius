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
├── .devcontainer/               ← configuration du Codespace (ouverture du port 6901 en HTTPS)
├── README.md                    ← vous êtes ici
├── docs/
│   └── Atelier_Filius.pdf       ← énoncé de l'atelier (5 exercices)
└── exercice4_ressources.fls     ← réseau de départ de l'exercice 4
```

---

## 1. Lancer l'environnement

1. Faire un **fork** de ce dépôt (bouton *Fork* en haut à droite).
2. Sur votre fork : **Code → Codespaces → Create codespace on main**.
3. Dans le terminal du Codespace, lancer la session Linux Kali :

   ```bash
   docker run --rm -it --shm-size=512m --user root --security-opt seccomp=unconfined -p 6901:6901 -e VNC_PW=password kasmweb/core-kali-rolling:1.17.0
   ```

   Le premier lancement prend quelques minutes (téléchargement de l'image Kali).
   **Ne pas fermer ce terminal** : la session Kali s'arrête si la commande est interrompue.
4. Quand le port **6901** apparaît, il s'ouvre dans un nouvel onglet (attention aux bloqueurs de
   popup). Sinon : onglet **PORTS** → icône 🌐 sur la ligne 6901. L'adresse se termine par
   `-6901.app.github.dev`.
5. Se connecter avec l'utilisateur `kasm_user` et le mot de passe `password`.

## 2. Installer Filius

Dans le **Terminal** de la session Linux Kali, passer en root :

```bash
su
```

Puis taper les commandes suivantes, une par une.

> ⚠️ **Copier-coller dans le terminal Kali :** `Ctrl+V` ne fonctionne pas. Copier la commande
> depuis cette page, puis faire un **clic droit** dans le terminal Kali → **Paste Clipboard**.

Mettre à jour la clé du dépôt Kali :

```bash
apt-get install -y gnupg curl ca-certificates
mkdir -p /etc/apt/keyrings
curl -fsSL https://archive.kali.org/archive-key.asc | gpg --dearmor -o /etc/apt/keyrings/kali-archive-keyring.gpg
chmod 644 /etc/apt/keyrings/kali-archive-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kali-archive-keyring.gpg] http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware" > /etc/apt/sources.list
```

Installer Java et git :

```bash
apt-get update
apt-get install -y default-jre git
```

Télécharger et installer Filius :

```bash
cd /tmp
curl -L -O https://www.lernsoftware-filius.de/downloads/Setup/filius_2.14.0_all.deb
apt-get install -y ./filius_2.14.0_all.deb
```

Si le fichier `.deb` est introuvable, la version a changé : prendre le lien du paquet Debian sur
https://www.lernsoftware-filius.de/Herunterladen.

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
| L'onglet ne s'ouvre pas | Autoriser les popups pour `app.github.dev`, ou onglet **PORTS** → 🌐 sur la ligne 6901. |
| Erreur **502 Bad Gateway** | Le port est en HTTP : onglet **PORTS** → clic droit sur 6901 → *Change Port Protocol* → **HTTPS**. |
| Le port 6901 n'apparaît pas | Kali n'a pas fini de démarrer : attendre, ou vérifier que la commande `docker run` tourne toujours. |
| Écran noir avec seulement le panneau KasmVNC | Le bureau n'a pas démarré : arrêter Kali (`Ctrl+C`) et relancer la commande `docker run` **avec** l'option `--security-opt seccomp=unconfined`. |
| `Ctrl+V` ne colle rien dans le terminal Kali | Faire un **clic droit** dans le terminal → **Paste Clipboard**. |
| « Page indisponible » | Le terminal du `docker run` a été fermé : relancer la commande `docker run`. |
| `apt-get` refuse de s'exécuter (permission) | Taper `su` puis relancer la commande. |
| Filius n'apparaît pas dans *Applications* | Fermer puis rouvrir le menu *Applications*, ou rechercher « Filius ». |
| Le `ping` échoue entre deux réseaux | Vérifier la **passerelle** de chaque machine (exercice 3, question 6). |
| La session Kali a disparu | Le Codespace s'est mis en veille : relancer la commande `docker run`, puis réinstaller Filius (étape 2). |
