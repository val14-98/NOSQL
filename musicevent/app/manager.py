import psycopg2

connexion = psycopg2.connect(user="postgres",
                             port=5432,
                             host="psql",
                             password="postgres",
                             database="musicevent")
cursor = connexion.cursor()


def getBands():
    s = []
    cursor.execute("SELECT Band.name, Band.mediaUrl, MusicType.name, to_char( date, 'YYYY/MM/DD'), City.name, Country.name FROM Concert inner join City on City.id = idCity inner join Country on Country.id = idCountry inner join Band on Band.id = idBand inner join MusicType on MusicType.id = idMusicType")
    for res in cursor.fetchall():
        s.append([res[0], res[1], res[2], res[3], res[4], res[5]])
    return s


