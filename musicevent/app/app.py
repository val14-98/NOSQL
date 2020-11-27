from flask import Flask, render_template, request
import manager

# import mongodb
app = Flask(__name__)


@app.route('/', methods=['GET'])
def accueil():
    # TODO : proposer concerts les plus proches
    #bands = manager.getBands()
    #,  bandsList=bands
    return render_template('index.html')


# /book?idConcert=17&firstName=testfirst&lastName=testlast&email=testemail
@app.route('/book', methods=['GET'])
def book():
    idConcert = request.args.get('idConcert')
    firstName = request.args.get('firstName')
    lastName = request.args.get('lastName')
    email = request.args.get('email')
    manager.book(idConcert, firstName, lastName, email)
     # TODO : proposer concerts les plus proches
    return render_template('index.html')


# /search?method=city&value=Marseille
@app.route('/search', methods=['GET'])
def search():
    searchMethod = request.args.get('method')
    value = request.args.get('value')
    if searchMethod == "city":
        data = manager.getConcertsByCity(value)
    elif searchMethod == "date":
        data = manager.getConcertsByDate(value)
    else:
        data = manager.getConcertsByArtist(value)

    return render_template('index.html', bandsList=data)





if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
