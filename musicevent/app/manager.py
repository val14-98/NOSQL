import psycopg2
import pymongo
from pymongo import MongoClient

#############################################
### Initialisation des connexions aux BDD ###
#############################################

# Initialisation de la connexion à PostgreSQL
psqlConnection = psycopg2.connect(user="postgres", port=5432, host="psql", password="postgres", database="musicevent")
psqlCursor = psqlConnection.cursor()

# Initialisation de la connexion à MongoDB
mongoClient = MongoClient(host='mongodb', port=27017,username='mongo',password='mongo')
mongoDB = mongoClient.musicevent            # ~= use musicevent
mongoCollection = mongoDB.newsletters       # définit la collection à manipuler


#############################################
### Initialisation de variables globales  ###
#############################################

# Début de toutes les requêtes qui retournent une liste de concerts
selectionQueryBase = "SELECT Concert.id, Band.name, Band.mediaUrl, MusicType.name, TO_CHAR(date :: DATE, 'yyyy-mm-dd') AS concertDate, City.name, Country.name " \
            "FROM Concert " \
            "inner join City on City.id = idCity " \
            "inner join Country on Country.id = idCountry " \
            "inner join Band on Band.id = idBand " \
            "inner join MusicType on MusicType.id = idMusicType " \
            "where date >= NOW() "

# Fin de toutes les requêtes qui retournent une liste de concerts
selectionQueryTermination = " ORDER BY concertDate DESC"



#############################################
###              Fonctions               ###
#############################################

# Récupère le contenu du curseur PostgreSQL et parse les données
# qu'il contient en array 2D dont chaque ligne représente un concert
# @return array
def parseSelectionResults():
    concertsData = []
    for dataRow in psqlCursor.fetchall():
        concertsData.append([dataRow[0], dataRow[1], dataRow[2], dataRow[3], dataRow[4], dataRow[5], dataRow[6]])
    return concertsData


# Recherche les concerts à venir qui ont lieu dans la ville passée en paramètre
# @param city : Le nom de la ville recherchée
# @return boolean : True si la requête a pu être correctement exécutée. False sinon
#         array2D : Array dont chaque ligne représente un concert (cf parseSelectionResults)
#                   = [] si boolean = False
def getConcertsByCity(city):
    query = selectionQueryBase + "AND LOWER(City.name) like '%"+city.lower()+"%'" + selectionQueryTermination
    try :
        psqlCursor.execute(query)
        return True, parseSelectionResults()
    except :
        return False, []

# Recherche les concerts à venir qui ont lieu à la date passée en paramètre
# @param date : La date recherchée
# @return boolean : True si la requête a pu être correctement exécutée. False sinon
#         array2D : Array dont chaque ligne représente un concert (cf parseSelectionResults)
#                   = [] si boolean = False
def getConcertsByDate(date):
    query = selectionQueryBase + "AND date = '"+date+"'" + selectionQueryTermination
    try :
        psqlCursor.execute(query)
        return True, parseSelectionResults()
    except:
        return False, []
    
# Recherche les concerts à venir qui mettent en scène l'artiste dont le nom est passé en paramètre
# @param artistName : Nom de l'artiste ou du groupe recherché
# @return boolean : True si la requête a pu être correctement exécutée. False sinon
#         array2D : Array dont chaque ligne représente un concert (cf parseSelectionResults)
#                   = [] si boolean = False
def getConcertsByArtist(artistName):
    query = selectionQueryBase + "AND LOWER(Band.name) like '%"+artistName.lower()+"%'" + selectionQueryTermination
    try :
        psqlCursor.execute(query)
        return True, parseSelectionResults()
    except :
        return False, []
    

# Recherche tous les concerts à venir, triés selon leur date
# @return boolean : True si la requête a pu être correctement exécutée. False sinon
#         array2D : Array dont chaque ligne représente un concert (cf parseSelectionResults)
#                   = [] si boolean = False
def getMainPageConcerts():
    query = selectionQueryBase + "ORDER BY concertDate ASC"
    try :
        psqlCursor.execute(query)
        return True, parseSelectionResults()
    except :
        return False, []
    

# Enregistre la réservation d'un utilisateur pour un concert
# @param idConcert : Identifiant du concert qui subit la réservation
# @param prenom : Prenom associé à la réservation
# @param nom : Nom associé à la réservation
# @param email : Adresse e-mail associée à la réservation
# @return boolean : True si la requête a pu être correctement exécutée. False sinon
def book(idConcert, prenom, nom, email):
    try:
        psqlCursor.execute("INSERT INTO Reservation (idConcert, firstName, lastName, email) VALUES (%s, %s, %s, %s)", (idConcert, prenom, nom, email))
        psqlConnection.commit()
        return True
    except :
        return False


# Recherche les 10 derniers concerts à avoir reçu une réservation
# @return boolean : True si la requête a pu être correctement exécutée. False sinon
#         array2D : Array dont chaque ligne représente un concert (cf parseSelectionResults)
#                   = [] si boolean = False
def getLastReservedConcerts():
    query  = "SELECT Concert.id, Band.name, Band.mediaUrl, MusicType.name, TO_CHAR(date :: DATE, 'yyyy-mm-dd') AS concertDate, City.name, Country.name "
    query += "FROM(SELECT idConcert, max(date) AS maxReservationDate FROM Reservation GROUP BY idConcert ORDER BY maxReservationDate DESC LIMIT 10) as subquery "
    query += "inner join concert on concert.id = subquery.idConcert "
    query += "inner join City on City.id = concert.idCity "
    query += "inner join Country on Country.id = city.idCountry "
    query += "inner join Band on Band.id = concert.idBand "
    query += "inner join MusicType on MusicType.id = band.idMusicType where date >= NOW() "
    query += "ORDER BY maxReservationDate DESC LIMIT 10"
    
    try :
        psqlCursor.execute(query)
        return True, parseSelectionResults()
    except :
        return False, []


# Ajoute une adresse e-mail à la liste des adresses souhaitant recevoir la newsletter
# @param email : Adresse e-mail à laquelle envoyer la newsletter 
# @param receiveAds : 1 si l'utilisateur souhaite recevoir des offres de nos partenaires. 0 sinon
# @return boolean : True si la requête a pu être correctement exécutée. False sinon
def subscribeToNewsletter(email, receiveAds):
    data = {"email":email, "receiveAds":receiveAds} 
    try:
        state = mongoCollection.insert_one(data)
        return True
    except:
        return False