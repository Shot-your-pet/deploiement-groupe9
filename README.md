# Shot Your Pet

Bienvenue sur le **code source** de l'application *Shot Your Pet* !  
Ce projet a été réalisé dans le cadre du module d’**Interopérabilité** (S4 Master MIAGE) à l'Université d'Orléans.

Si vous n'arrivez pas à suivre le tutoriel, vous pouvez vous rendre ici : [Shot Your Pet](https://shotyourpet.toves.fr/)

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
- [deploiement-groupe9](https://pdicost.univ-orleans.fr/git/projects/PINTEROP/repos/deploiement-groupe9/browse)  **Depot temporaire de l'implémentation des TI**
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

## Tests de l'API

### Requête rapide http pour API

Dans le répertoire /requetes_http, des fichiers de requêtes (ex.: *login.http* ou équivalent) regroupent un grand nombre de requêtes pour tester les différents services.
- Mettez la bonne URL.
- Connectez-vous grâce à la requête *login* sur login.http.
- Explorez pour couvrir la plupart des endpoints.

*(Tous les endpoints n’y figurent pas, mais une grande partie y est.)*

### TI Karate

Le répertoire **karate** se trouve dans src/test/java contient les tests d’intégration réalisés avec **Karate**.

#### Prérequis

Les tests d'intégration nécessitent d'avoir l'application déployée et en cours d'exécution. Il faut également disposer d'un compte keycloack, la création de compte keycloack n'est pas gérée par les tests. Celui-ci étant un service externe ne faisant pas partie du périmètre de test. 

Les informations de compte sont à renseigner dans le fichier auth-keycloack.feature.

Pour le lancement manuel de test, celui-ci est possible via le lancement de **KarateRunnerTest.java.** Le lancement des .feature est également possible si vous disposez d'un abonnement aux services de karate lab.
Cette configuration permet de lancer les tests d'intégrations sans dépendre d'un abonnement à karate lab. 


(L'appel à notre API est sécurisé par les tokens Keycloack, ce service peut avoir un fonctionnement instable lors d'une campagne de tests)
- Pour exécuter les tests, il suffit de lancer la commande suivante :
```mvn test -Dtest=KarateRunnerTest```

---

## Déploiement sur le Cloud

Un répertoire **terraform** contient les fichiers nécessaires pour déployer quelques éléments de l’application sur **Azure**.
- *Fonctionnalité expérimentale.*

---

## Monitoring

L'application dispose d'un système de monitoring assuré par Grafana, Loki, et Premetheus.
- Grafana est utilisé pour la visualisation des données.
- Loki est utilisé pour la gestion des logs.
- Prometheus est utilisé pour la collecte des métriques.
- Promtail est utilisé pour l'envoi des logs vers Loki.

Une fois l'application lancé vous pouvez accéder à Grafana via l'url suivante : [http://localhost:3000](http://localhost:3000) avec les identifiants suivants : admin:admin
Ajouter une source de données Loki avec l'url suivante : http://loki:3100 (doit être fait également pour prometheus : http://prometheus:9090)
Et vous pourrez visualiser les logs

Attention : fonctionne sous Linux (Windows non à cause de la gestion des volumes docker)

---


## Documents et informations utiles

- Le dossier **documents** contient :
    - Le *DAT* (Dossier d’Architecture Technique)
    - Une documentation *Swagger*
    - un png du schéma de l'architecture de l'application (identique à celui du DAT)

- Chaque projet dispose de son propre pipeline **CI/CD**.
- Des tests unitaires sont présents sur plusieurs projets.
- Toutes les fonctionnalités liées à l’utilisateur sont gérées par **Keycloak**.
- Il y a 2 types de notification : 
  - Push 
  - Email

## Roles de chaque service
- **Utilisateur** : 
  - Permet de lier les utilisateurs du realms Keycloak à l'application.
  - Récupère chaque action effectuée sur keycloak par listeneur d'évènement manipulé par le SPI et l'envoie sur la queue rabbitmq pour être traité coté service utilisateur
  - Envoie les informations des utilisateurs quand un service en a besoin
  - Met à jour l'id de l'image qui correspond à l'avatar de l'utilisateur (envoyé par le service d'image)
- **Image** : 
  - Permet de stocker les images envoyées par les utilisateurs que ce soit pour les publications et les avatars
  - Envoie l'id de l'image au service utilisateur si l'image est un avatar
  - Envoie au client l'image lorsqu'il le demande (affichage coté frontend)
- **Challenge** : 
  - Permet de gérer les challenges coté admin (GET, POST, PUT, DELETE)
  - Génère un nouveau challenge tous les jours en fonction du cron et envoie le nouveau challenge au service de notification
  - Envoie au frontend le challenge du jour
  - Permet a publication de vérifier si la publication correspond au challenge du jour
- **Notification** : 
  - Permet d'envoyer des notifications push et email lors de la reception du nouveau challenge quotidien
  - Permet de gérer les abonnements aux notifications push (endpoint, keys etc ...) (pas de firebase)
- **Frontend** : 
  - Permet d'afficher l'application et de gérer les interactions utilisateurs
  - Permet de se connecter à keycloak pour s'authentifier
  - Permet de se connecter à la gateway pour ensuite rooting des demandes
- **Gateway** : 
  - Permet de router les demandes vers les différents services
  - Permet de gérer la sécurité des services (authentification, autorisation)
  - Permet de gérer les requêtes envoyées par le frontend et de les router vers le bon service
- **Timeline** :
  - permet de stocker les publications
  - permet de récupérer les publications avec le nom de l'auteur et de filtrer par challenge ou auteur
- **Publication** :
  - permet de valider les publications selon si l'auteur existe et qu'il n'a pas déjà répondu au challenge du jour
  - envois la publication a timeline via une file rabbitmq

## Workflow

Lorsqu'un utilisateur souhaite publier un post, le processus se déroule comme suit :

1. **Envoi de l'image** :
    - Le front envoie une première requête avec l'image sous form-data au service d'image.
    - Le service d'image enregistre l'image en lui générant un ID au format Snowflake et renvoie cet ID au front.

2. **Envoi des détails de la publication** :
    - Le front procède à un deuxième appel API après la réception de l'ID de l'image.
    - Il appelle le service de publication avec la description du post et l'ID de l'image reçu.

3. **Vérifications et stockage** :
    - Le service de publication vérifie si l'utilisateur est connecté et s'il a déjà publié ou non durant le challenge.
    - Une fois les vérifications effectuées, le service de publication envoie le post à la timeline.
    - La timeline stocke la publication pour qu'elle soit rendue côté front.

---

## Contact

Pour toute question ou suggestion, veuillez contacter l'équipe de développement.

---

© 2025 | Université d'Orléans | Shot Your Pet.