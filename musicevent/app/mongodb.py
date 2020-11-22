import redis
from pymongo import MongoClient
#Step 1: Connect to MongoDB - Note: Change connection string as needed
client = MongoClient(host='mongodb',port=27017,username='root',password='example')
db=client.suggestion

#redis

cache = redis.Redis(host='redis', port=6379)


def add(text,nom,prenom):
    global db,client
    adddb = { 
            "nom":nom, 
            "prenom":prenom, 
            "text":text
            } 
    if db.reviews.find(adddb).count()>=1:
        return "Suggestion déjà noté"
    db.reviews.insert_one(adddb)
    cache.set(text+nom+prenom,text)
    return cache.get(text+nom+prenom).decode("utf-8") 