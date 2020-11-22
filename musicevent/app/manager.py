import psycopg2

connexion = psycopg2.connect(user="postgres",
                             port=5432,
                             host="psql",
                             password="postgres",
                             database="musicevent")
cursor = connexion.cursor()


def getBands():
    s = []
    cursor.execute("SELECT name FROM band")
    for res in cursor.fetchall():
        s.append(res[0])
    return s
