from flask import Flask, render_template, request
import manager

# TODO : commenter et détailler __name__

app = Flask(__name__)


# Définition de l'URL qui déclenche l'appel de la fonction
@app.route('/', methods=['GET'])  
# Récupère les données à afficher dans la page d'accueil et les passe à la page index.hml
def accueil():
    # Récupération des données
    query_1_state, concerts               = manager.getMainPageConcerts()
    query_2_state, lastlyReservedConcerts = manager.getLastReservedConcerts()

    # Passage des données à la page Web
    return render_template('index.html',
                            queryState = query_1_state and query_2_state,
                            concertsList=concerts,
                            lastBookedConcerts=lastlyReservedConcerts)


# Définition de l'URL qui déclenche l'appel de la fonction
@app.route('/book', methods=['GET'])
# Réserve une place à un concert pour l'utilisateur
def book():
    # Récupération des paramètres
    idConcert = request.args.get('idConcert')
    firstName = request.args.get('firstName')
    lastName = request.args.get('lastName')
    email = request.args.get('email')

    # Récupération des données
    query_1_state                         = manager.book(idConcert, firstName, lastName, email)
    query_2_state, concerts               = manager.getMainPageConcerts()
    query_3_state, lastlyReservedConcerts = manager.getLastReservedConcerts()

    # Passage des données à la page Web
    return render_template('index.html',
                            queryState = query_1_state and query_2_state and query_3_state,
                            concertsList=concerts,
                            lastBookedConcerts=lastlyReservedConcerts)



# Définition de l'URL qui déclenche l'appel de la fonction
@app.route('/search', methods=['GET'])
# Récupère les données à afficher selon les paramètres de la recherche et les passe à la page index.hml
def search():
    # Récupération des paramètres
    searchMethod = request.args.get('method')
    value = request.args.get('value')

    # Récupération des données
    if searchMethod == "city":
        query_1_state, concerts = manager.getConcertsByCity(value)
    elif searchMethod == "date":
        query_1_state, concerts = manager.getConcertsByDate(value)
    else:
        query_1_state, concerts = manager.getConcertsByArtist(value)

    query_2_state, lastlyReservedConcerts = manager.getLastReservedConcerts()

    # Passage des données à la page Web
    return render_template('index.html',
                            queryState = query_1_state and query_2_state,
                            concertsList=concerts,
                            lastBookedConcerts=lastlyReservedConcerts)



# Définition de l'URL qui déclenche l'appel de la fonction
@app.route('/subscribe', methods=['GET'])
# Ajoute une adresse e-mail à la liste des e-mail souhaitant recevoir la newsletter
def subscribeToNewsletter():
    # Récupération des paramètres
    email = request.args.get('email')
    offers = request.args.get('offers')

    # Récupération des données
    query_1_state                         = manager.subscribeToNewsletter(email, offers)
    query_2_state, concerts               = manager.getMainPageConcerts()
    query_3_state, lastlyReservedConcerts = manager.getLastReservedConcerts()

    # Passage des données à la page Web
    return render_template('index.html',
                            queryState = query_1_state and query_2_state and query_3_state,
                            concertsList=concerts,
                            lastBookedConcerts=lastlyReservedConcerts)



if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)


# /book?idConcert=3&firstName=testfirst&lastName=testlast&email=testemail
# /search?method=city&value=toulou
# /search?method=date&value=2021-02-15
# /search?method=artist&value=bat
#/subscribe?email=testemail&offers=1
