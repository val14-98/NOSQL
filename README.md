# NOSQL

<h2>INTRODUCTION</h2>

Notre projet est un site de recherche et de réservation de concert.
Il est possible de réaliser des recherches, par artiste, par ville ou pas date de concert.

Ce projet est composé de 3 dockers :

- Flask pour l'interface web
- Postgresql pour les concerts et les résevations
- Mongodb pour les newsletters

<h2>LANCER LE PROJET</h2>

Pour lancer le projet :

- Lancer "docker-compose up -d" une première fois dans le dossier /musicevent.

Le projet est initialisé,

- Relancer le projet avec "docker-compose up", cette fois-ci le projet se lance.

Le serveur tourne sur le port 5000.

- Accèder au site depuis http://localhost:5000

<h2>VISUALISER LA PERSISTANCE DES DONNÉES</h2>

Pour visualiser la persistance des données vous pouvez accèder aux bases postgresql et mongoDB :

Postgresql : sudo docker exec -it musicevent_psql_1 bash
             psql -U postgres
             \c musicevent
             \dt
             
MongoDB : sudo docker exec -it musicevent_mongodb_1 bash
          mongo -u mongo -p mongo
          show dbs
          use dbName
          show collections
          db.collectionName.find()

<h2>CONTENU DES DOSSIERS</h2>

Dossier /psql : Contient le dockerfile pour d'installation des librairies depuis "requirements.txt" et également le contenu de la db "musicevent.sql"

Dossier /app : Contient app.py qui est le main du projet qui intéragit avec la vue et manager.py qui dialogue avec les bases de données postgresql et mongoDB

        /app/templates/ : Contient la vue du projet 
        
            index.html est notre vue en html.
        
        /app/static/ : Contient les fichiers statics de style et de jquery
        
             jsfile.hs est notre fichier jquery qui permet d'animer la page.
             
             style.css est la feuille de style du projet.
             
Pour la mise en forme de la vue nous utilisons bootstrap.
