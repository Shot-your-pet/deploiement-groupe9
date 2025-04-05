# Shot Your Pet

Bienvenue sur le **code source** de l'application *Shot Your Pet* !  
Ce projet a été réalisé dans le cadre du module d’**Interopérabilité** (S4 Master MIAGE) à l'Université d'Orléans.

Si vous arrivez pas à suivre le tutoriel, vous pouvez vous rendre ici : [Shot Your Pet](https://shotyourpet.toves.fr/)

## Membres

- Emma
- Tom
- Ian
- Aymeric
- Maxime

> *(Les noms de famille sont volontairement omis pour des raisons de confidentialité. Dépot publique github)*

---

## Liens vers les différents dépôts

### GitHub (public)
- [Shot-your-pet/packages](https://github.com/orgs/Shot-your-pet/packages)
- [Shot-your-pet/utilisateur-groupe9](https://github.com/Shot-your-pet/utilisateur-groupe9)
- [Shot-your-pet/notification-groupe9](https://github.com/Shot-your-pet/notification-groupe9)
- [Shot-your-pet/images-groupe9](https://github.com/Shot-your-pet/images-groupe9)
- [Shot-your-pet/challenges-groupe9](https://github.com/Shot-your-pet/challenges-groupe9)
- [Shot-your-pet/timeline-groupe9](https://github.com/Shot-your-pet/timeline-groupe9)
- [Shot-your-pet/publications-groupe9](https://github.com/Shot-your-pet/publications-groupe9)
- [Shot-your-pet/deploiement-groupe9](https://github.com/Shot-your-pet/deploiement-groupe9)
- [Shot-your-pet/frontend-groupe9](https://github.com/Shot-your-pet/frontend-groupe9)

### PDICOST (privé, branches *main* pour l'évaluation)
- [utilisateur-groupe9](https://pdicost.univ-orleans.fr/git/projects/PINTEROP/repos/utilisateur-groupe9/browse)
- [notification-groupe9](https://pdicost.univ-orleans.fr/git/projects/PINTEROP/repos/notification-groupe9/browse)
- [images-groupe9](https://pdicost.univ-orleans.fr/git/projects/PINTEROP/repos/images-groupe9/browse)
- [challenges-groupe9](https://pdicost.univ-orleans.fr/git/projects/PINTEROP/repos/challenges-groupe9/browse)
- [timeline-groupe9](https://pdicost.univ-orleans.fr/git/projects/PINTEROP/repos/timeline-groupe9/browse)
- [publications-groupe9](https://pdicost.univ-orleans.fr/git/projects/PINTEROP/repos/publications-groupe9/browse)
- [deploiement-groupe9](https://pdicost.univ-orleans.fr/git/projects/PINTEROP/repos/deploiement-groupe9/browse)
- [frontend-groupe9](https://pdicost.univ-orleans.fr/git/projects/PINTEROP/repos/frontend-groupe9/browse)

#### Dépôts non utilisés (faute de temps) :
- [friends-groupe9](https://pdicost.univ-orleans.fr/git/projects/PINTEROP/repos/friends-groupe9/browse)
- [bff-groupe9](https://pdicost.univ-orleans.fr/git/projects/PINTEROP/repos/bff-groupe9/browse)
- [test-integration-groupe9](https://pdicost.univ-orleans.fr/git/projects/PINTEROP/repos/test-integration-groupe9/browse)
- [gitlabci-groupe9](https://pdicost.univ-orleans.fr/git/projects/PINTEROP/repos/gitlabci-groupe9/browse)

---

## Documentation

### Mise en place de l’application

1. **Cloner** le dépôt `deploiement-groupe9` **uniquement**.
2. **Renommer** le fichier `.env.example` en `.env` et renseignez les variables :
    - Remplacez `<adresse_ip>` par l’adresse IP de votre machine ou votre hostname (exemple : `$hostnamectl -I`)
    - Générez vos clés VAPID via [vapidkeys.com](https://vapidkeys.com/)
    - Saisissez vos informations SMTP (optionnel, si non configuré, le service de notifications générera des erreurs)
3. Lancez la commande :
   ```bash
   docker-compose up -d
   ```
4. Lorsque les conteneurs sont démarrés, rendez-vous sur [http://localhost:8080](http://localhost:8080) (de préférence sous Chrome si vous souhaitez utiliser la fonctionnalité de *shoot*).

Si l’interface de connexion apparaît, c’est que tout est opérationnel !

---

## Présentation de l’application

**Shot Your Pet** est une application de partage de photos d’animaux de compagnie. Elle comprend principalement **3 pages** :

1. **Timeline**
    - Affiche les publications des autres utilisateurs.
    - Affiche également le *challenge du jour*.
    - Demande d’autoriser les notifications push (acceptez pour recevoir des notifications).

2. **Shoot**
    - Permet de prendre une photo rapidement (vous ou votre animal).
    - Saisissez une description (optionnel) puis validez.
    - Un léger délai peut se produire avant l’affichage sur la timeline (temps de traitement).

3. **Profil**
    - Affiche votre profil utilisateur.
    - Permet de modifier votre nom d’utilisateur et votre mot de passe (géré par *Keycloak*).
    - Vous pouvez changer votre avatar en cliquant simplement dessus.

---

## Tests

Dans ce répertoire, un fichier de requêtes (ex.: *login.http* ou équivalent) regroupe un grand nombre de requêtes pour tester les différents services.
- Mettez la bonne URL.
- Connectez-vous grâce à la requête *login* sur login.http.
- Explorez pour couvrir la plupart des endpoints.

*(Tous les endpoints n’y figurent pas, mais une grande partie y est.)*

---

## Déploiement sur le Cloud

Un répertoire **terraform** contient les fichiers nécessaires pour déployer l’application sur **Azure**.
- *Fonctionnalité expérimentale, néanmoins fonctionnelle.*

---

## Documents et informations utiles

- Le dossier **documents** contient :
    - Le *DAT* (Dossier d’Architecture Technique)
    - Une documentation *Swagger*

- Chaque projet dispose de son propre pipeline **CI/CD**.
- Des tests unitaires sont présents sur plusieurs projets.
- Toutes les fonctionnalités liées à l’utilisateur sont gérées par **Keycloak**.
- Il y a 2 types de notification : 
  - Push 
  - Email (non désactivable 😉)