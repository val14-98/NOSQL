# NOSQL


Lancer le docker si problème lors de la création de la BDD :
1. sudo docker volume rm $(sudo docker volume ls -qf dangling=true)
2. sudo docker volume ls
3. sudo docker volums rm <volume terminant par _psql>
4. sudo docker compose-up

Si erreur liée à un orphelin, répéter les étapes précédentes 1 à 3 puis sudo docker-compose up --remove-orphans 

sudo docker system prune -a
