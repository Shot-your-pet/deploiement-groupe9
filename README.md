# Shot Your Pet
Bienvenu sur le code source de l'application Shot Your Pet 
Projet Interopérabilité de S4 Master MIAGE à l'Université d'Orléans

Membres : (Pas les noms de famille, car publique sur github)
    Emma
    Tom
    Ian
    Aymeric
    Maxime

Le projet est disponible sur les liens suivants :

# GitHub (publique)
https://github.com/orgs/Shot-your-pet/packages

https://github.com/Shot-your-pet/utilisateur-groupe9
https://github.com/Shot-your-pet/notification-groupe9
https://github.com/Shot-your-pet/images-groupe9
https://github.com/Shot-your-pet/challenges-groupe9
https://github.com/Shot-your-pet/timeline-groupe9
https://github.com/Shot-your-pet/publications-groupe9
https://github.com/Shot-your-pet/deploiement-groupe9
https://github.com/Shot-your-pet/frontend-groupe9

# Pdicost (privée) sur les branches main
https://pdicost.univ-orleans.fr/git/projects/PINTEROP/repos/utilisateur-groupe9/browse
https://pdicost.univ-orleans.fr/git/projects/PINTEROP/repos/notification-groupe9/browse
https://pdicost.univ-orleans.fr/git/projects/PINTEROP/repos/images-groupe9/browse
https://pdicost.univ-orleans.fr/git/projects/PINTEROP/repos/challenges-groupe9/browse
https://pdicost.univ-orleans.fr/git/projects/PINTEROP/repos/timeline-groupe9/browse
https://pdicost.univ-orleans.fr/git/projects/PINTEROP/repos/publications-groupe9/browse
https://pdicost.univ-orleans.fr/git/projects/PINTEROP/repos/deploiement-groupe9/browse
https://pdicost.univ-orleans.fr/git/projects/PINTEROP/repos/frontend-groupe9/browse

https://pdicost.univ-orleans.fr/git/projects/PINTEROP/repos/friends-groupe9/browse // Pas utilisé manque de temps
https://pdicost.univ-orleans.fr/git/projects/PINTEROP/repos/bff-groupe9/browse // Pas utilisé manque de temps
https://pdicost.univ-orleans.fr/git/projects/PINTEROP/repos/test-integration-groupe9/browse // Pas utilisé manque de temps
https://pdicost.univ-orleans.fr/git/projects/PINTEROP/repos/gitlabci-groupe9/browse // Pas utilisé manque de temps désolé

# Documentation
Comment la mettre en place : 
- cloner le projet deploiement-groupe9 uniquement
- renommer le fichier .env.example en .env et mettez-y les valeurs (beaucoup sont déjà pré-remplis)
    - Remplacer <adresse_ip> par l'adresse ip de votre machine ou votre hostname : $hostnamectl -I (pas de localhost)
    - Générer vos clés VAPID sur ce lien : https://vapidkeys.com/
    - Saisir vos informations SMTP (pas bloquant pour, causera juste une erreur à répétition dans le service de notifications)
- Lancer la commande $docker-compose up -d
- Théoriquement l'application est prête à l'emploi : aller sur http://localhost:8080 (avec chrome, car chez moi chrome ça marche (pour la fonctionnalité de shoot))
Si vous accédez à l'interface de connexion alors, vous êtes bon.

# Présentation
L'application Shot Your Pet est une application de partage de photos de vos animaux de compagnie.
3 pages sont présentes : 
    - Timeline : affichage des publications des autres utilisateurs et affichage du challenge du jour. Normalement, vous êtes invité à accepter les notifications, dites oui pour recevoir des notifications push
    - Shoot : Simplement une page pour vous capturer en photo ou votre animal, bref pour prendre en photo. Shootez, saisissez une description si vous voulez et hop (Il se peut qu'il y ait un petit temps avant de voir sur la timeline, c'est le temps de traitement)
    - Profil : Affichage de votre profil, vous pouvez modifier votre nom d'utilisateur et votre mot de passe sur l'interface de keycloak. Changez votre Avatar également par simple appuie dessus

# Tests de nerds 
Dans ce repertoire se trouve un fichier de requête qui englobe un gros panel de requêtes sur les différents services, mettez bien la bonne url, connectez-vous avec la requête login et fouillez.
Tous les endpoints ne s'y trouve pas, mais la plupart y sont.

# Cloud
Le repertoire terraform contient des fichiers terraform pour déployer l'application sur un cloud Azure
Encore très expérimental, mais ça fonctionne.

# Documents et informations utiles
Dans le repertoire documents se trouve le dossier architectural de l'application (DAT) ainsi qu'une doc swagger

Les différents projets ont chacun leur CI/CD (pas ²)
Des TUs sont présents dans les projets

Tous ce qui concerne l'utilisateur est géré par keycloak


