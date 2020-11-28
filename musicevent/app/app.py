from flask import Flask, render_template, request
import manager

# TODO : commenter et détailler __name__
# TODO : renommer variables state, etc...

app = Flask(__name__)



@app.route('/', methods=['GET'])
def accueil():
    query_1_state, concerts = manager.getMainPageConcerts()
    query_2_state, lastResa = manager.getLastReservedConcerts()
    return render_template('index.html',
                            queryState = query_1_state and query_2_state,
                            concertsList=concerts,
                            lastBookedConcerts=lastResa)


@app.route('/book', methods=['GET'])
def book():
    idConcert = request.args.get('idConcert')
    firstName = request.args.get('firstName')
    lastName = request.args.get('lastName')
    email = request.args.get('email')

    state                   = manager.book(idConcert, firstName, lastName, email)
    query_1_state, concerts = manager.getMainPageConcerts()
    query_2_state, lastResa = manager.getLastReservedConcerts()

    return render_template('index.html',
                            queryState = state and query_1_state and query_2_state,
                            concertsList=concerts,
                            lastBookedConcerts=lastResa)


@app.route('/search', methods=['GET'])
def search():
    searchMethod = request.args.get('method')
    value = request.args.get('value')
    if searchMethod == "city":
        state, concerts = manager.getConcertsByCity(value)
    elif searchMethod == "date":
        state, concerts = manager.getConcertsByDate(value)
    else:
        state, concerts = manager.getConcertsByArtist(value)

    query_1_state, lastResa = manager.getLastReservedConcerts()
    return render_template('index.html',
                            queryState = state and query_1_state,
                            concertsList=concerts,
                            lastBookedConcerts=lastResa)




@app.route('/subscribe', methods=['GET'])
def subscribeToNewsletter():
    email = request.args.get('email')
    offers = request.args.get('offers')
    state = manager.subscribeToNewsletter(email, offers)
    query_1_state, concerts = manager.getMainPageConcerts()
    query_2_state, lastResa = manager.getLastReservedConcerts()
    return render_template('index.html',
                            queryState = state and query_1_state and query_2_state,
                            concertsList=concerts,
                            lastBookedConcerts=lastResa)



if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)


# /book?idConcert=3&firstName=testfirst&lastName=testlast&email=testemail
# /search?method=city&value=toulou
# /search?method=date&value=2021-02-15
# /search?method=artist&value=bat
#/subscribe?email=testemail&offers=1