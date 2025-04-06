EventListener Keycloak
Ce projet permet de créer le SPI Keycloak qui va permettre d'envoyer les événements keycloak sur une file rabbit pour être traité par le microservice des utilisateurs et /ou les autres microservices.


## Utilisation
Configurer les variables d'environnement, si elles ne sont pas trouvés, des variables sont déjà incluses (localhost:5672 : guest:guest)

$ mvn package

Puis lancer le container keycloak (attention à bien vérifier que le volume est bien monté)

Pour l'utiliser sur les autres projets, la file qui renvoie les événements est `keycloak_events`
