import psycopg2

# TODO : si saisie contient des quotes (simple ou double) : problème
# TODO : filtrer sur concerts à venir
# TODO : après appel d'une fonction, réinitialiser l'url dans le navigateur
# TODO : to lower
# TODO : cursor.close()
# TODO : 2 eme var à retourner (bool) = false si requete failed


connexion = psycopg2.connect(user="postgres",
                             port=5432,
                             host="psql",
                             password="postgres",
                             database="musicevent")
cursor = connexion.cursor()

selectionQueryBase = "SELECT Concert.id, Band.name, Band.mediaUrl, MusicType.name, TO_CHAR(date :: DATE, 'yyyy-mm-dd') AS concertDate, City.name, Country.name " \
            "FROM Concert " \
            "inner join City on City.id = idCity " \
            "inner join Country on Country.id = idCountry " \
            "inner join Band on Band.id = idBand " \
            "inner join MusicType on MusicType.id = idMusicType " \
            "where date >= NOW() "


def parseSelectionResults():
    concertsData = []
    for dataRow in cursor.fetchall():
        concertsData.append([dataRow[0], dataRow[1], dataRow[2], dataRow[3], dataRow[4], dataRow[5], dataRow[6]])
    return concertsData



def getConcertsByCity(city):
    query = selectionQueryBase + "AND City.name like '%"+city+"%'"
    try :
        cursor.execute(query)
        return True, parseSelectionResults()
    except :
        return False, []


def getConcertsByDate(date):
    query = selectionQueryBase + "AND date = '"+date+"'"
    try :
        cursor.execute(query)
        return True, parseSelectionResults()
    except:
        return False, []
    

def getConcertsByArtist(artistName):
    query = selectionQueryBase + "AND Band.name like '%"+artistName+"%'"
    try :
        cursor.execute(query)
        return True, parseSelectionResults()
    except :
        return False, []
    


def getMainPageConcerts():
    query = selectionQueryBase + "ORDER BY concertDate ASC"
    try :
        cursor.execute(query)
        return True, parseSelectionResults()
    except :
        return False, []
    


def book(idConcert, prenom, nom, email):
    try:
        cursor.execute("INSERT INTO Reservation (idConcert, firstName, lastName, email) VALUES (%s, %s, %s, %s)", (idConcert, prenom, nom, email))
        connexion.commit()
        return True
    except :
        return False




def getLastReservedConcerts():
    subsubquery = "SELECT idConcert, max(date) AS maxReservationDate FROM Reservation GROUP BY idConcert ORDER BY maxReservationDate DESC LIMIT 10"
    subquery = "AND Concert.id IN(SELECT idConcert FROM ("+subsubquery+") AS concertSelection"
    query = selectionQueryBase + subquery +")"
    try :
        cursor.execute(query)
        return True, parseSelectionResults()
    except :
        return False, []


#def subscribeToNewsletter(email, receiveAds):
