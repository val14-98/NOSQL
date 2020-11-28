# NOSQL


Lancer le docker si problème lors de la création de la BDD :
1. sudo docker-compose down
2. sudo docker volume rm $(sudo docker volume ls -qf dangling=true)
3. sudo docker volume ls
4. sudo docker volume rm <volume terminant par _psql>
5. sudo docker-compose up

Si erreur liée à un orphelin, répéter les étapes précédentes 2 à 4 puis sudo docker-compose up --remove-orphans 

sudo docker system prune -a




sudo docker exec -it musicevent_mongodb_1 bash
mongo -u mongo -p mongo
show dbs
use dbName
show collections
db.collectionName.find()
