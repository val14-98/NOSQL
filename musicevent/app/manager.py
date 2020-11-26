import psycopg2

# TODO : si saisie contient des quotes (simple ou double) : problème
# TODO : filtrer sur concerts à venir
connexion = psycopg2.connect(user="postgres",
                             port=5432,
                             host="psql",
                             password="postgres",
                             database="musicevent")
cursor = connexion.cursor()

selectionQueryBase = "SELECT Concert.id, Band.name, Band.mediaUrl, MusicType.name, TO_CHAR(date :: DATE, 'yyyy-mm-dd'), City.name, Country.name " \
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
    cursor.execute(query)
    return parseSelectionResults()

# TODO : si format != format date, erreur. Retourneer null ou try catch ?
def getConcertsByDate(date):
    query = selectionQueryBase + "AND date = '"+date+"'"
    cursor.execute(query)
    return parseSelectionResults()

def getConcertsByArtist(artistName):
    query = selectionQueryBase + "AND Band.name like '%"+artistName+"%'"
    cursor.execute(query)
    return parseSelectionResults()

#def getLastReservedConcerts():
'''
SELECT DISTINCT Band.name, Band.mediaUrl, TO_CHAR(Concert.date :: DATE, 'yyyy-mm-dd'), City.name
from Concert
inner join Reservation on Concert.id = Reservation.idConcert
inner join City on City.id = idCity
inner join Band on Band.id = idBand
ORDER BY Reservation.date ASC LIMIT 5; 
'''

# def book(idConcert, prenom, nom, email)