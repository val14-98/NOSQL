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
    # TODO : insert en bdd
    data = []
    data.append(idConcert)
    data.append(firstName)
    data.append(lastName)
    data.append(email)
    return render_template('index.html', bandsList=data)


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

'''
@app.route('/', methods=['POST'])
def my_form_post():
    
    #Get data of listbox
    specialites = request.form.getlist('specialite')
    alternance = request.form.getlist('alternance')
    concours = request.form.getlist('concours')
    regions = request.form.getlist('region')
    annee = request.form.getlist('annee')
    



    specialites =main.renvoie_idspe(specialites)
    

    

    #Check list vide
    if specialites==[]:
        specialites=None
    if alternance==[] or alternance==["Peu importe"]:
        alternance=None
    if concours==[]:
        concours=None
    if regions==[]:
        regions=None
    if annee==[]:
        annee=None

    choix_utilisateur={"specialites":specialites,
                        "alternance":alternance,
                        "concours":concours,
                        "regions":regions,
                        "annee":annee}

    

    #Get Notes
    maths = request.form['maths']
    physique=request.form['physique']
    si=request.form['si']
    informatique=request.form['informatique']
    anglais=request.form['anglais']
    francais=request.form['francais']
    modelisation=request.form['modelisation']

    notes={"maths":maths,
            "physique":physique,
            "si":si,
            "informatique":informatique,
            "anglais":anglais,
            "francais":francais,
            "modelisation":modelisation}

    ecole=main.filtre(choix_utilisateur,notes)
    ecolesdef=[]

    for eco in ecole:
        if eco[5] not in ecolesdef:
            ecolesdef.append(eco[5])



    
    return render_template('affichage.html', ecole=ecolesdef)

'''

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
