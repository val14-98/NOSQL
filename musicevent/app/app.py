from flask import Flask, render_template, request
import manager

#import pymongo
#from pymongo import MongoClient


#client = MongoClient(host=['localhost:27017'],username='mongo',password='mongo') #host='mongodb', port=27017
'''client = MongoClient()
db = client.test_database
collection = db.test_collection

document1 = {
    "name":"John",
    "age":24,
    "location":"New York"
    }

collection.insert_one(document1)
'''


app = Flask(__name__)



@app.route('/', methods=['GET'])
def accueil():




    #posts = db.posts
    '''new_posts = [
        {"author": "Mike",
                "text": "Another post!",
                "tags": ["bulk", "insert"]},
                {"author": "Eliot",
                "title": "MongoDB is fun",
                "text": "and pretty easy too!"}
                ]
    result = posts.insert_many(new_posts)
    result.inserted_ids'''


    query_1_state, concerts = manager.getMainPageConcerts()
    query_2_state, lastResa = manager.getLastReservedConcerts()
    return render_template('index.html',
                            queryState = query_1_state and query_2_state,
                            concertsList=concerts,
                            lastBookedConcerts=lastResa)


# /book?idConcert=17&firstName=testfirst&lastName=testlast&email=testemail
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


# /search?method=city&value=Marseille
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




if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)


# /book?idConcert=3&firstName=testfirst&lastName=testlast&email=testemail
# /search?method=city&value=toulou
# /search?method=date&value=2021-02-15
# /search?method=artist&value=bat
