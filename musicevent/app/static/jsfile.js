//NOTA
//MODIFICATION DES NOM DES INPUT ET BOUTON DANS INDEX
let method = "artist";
let idConcert;
$(document).ready(function () {

     //detecter url après une reservation et rediriger
     if(document.location.href.includes('book?')) {
     alert("book detect");
        document.location.href = document.location.origin;
        
    }
       
    $('input[type=radio][name=inlineRadioOptions]').change(function () {
        $('#button-addon2').prop('disabled', false);
        if ($('#inlineRadio1').is(':checked')) {
            //alert("BY ARTIST/GROUP");
            method = "artist";
        } else if ($('#inlineRadio2').is(':checked')) {
            //alert("BY CITY");
            method = "city";
        } else if ($('#inlineRadio3').is(':checked')) {
            //alert("BY DATE");
            method = "date";
        }
    });

    //Redirection formulaire research
    $("#button-research").click(function () {
        $('#space_alert').html('<div class="alert alert-danger collapse alerts" role="alert">\n' +
            '                Error, please enter data in the format YYYY/MM/DD\n' +
            '                <button type="button" class="close" data-dismiss="alert" aria-label="Close">\n' +
            '                    <span aria-hidden="true">&times;</span>\n' +
            '                </button>\n' +
            '            </div>\n' +
            '            <div class="alert alert-danger collapse alerts" role="alert">\n' +
            '                Error, please enter a date that has not passed\n' +
            '                <button type="button" class="close" data-dismiss="alert" aria-label="Close">\n' +
            '                    <span aria-hidden="true">&times;</span>\n' +
            '                </button>\n' +
            '            </div>');
        let research = $("#research_input_fill").val();
        if(method === "date"){
           let date =  Date.parse(research);
           if (isNaN(date) === false) {
               let current_date = new Date();
                if(date >= current_date.getTime('YYYY-MM-DD')){
                    document.location.href = "search?method=" + method + "&value=" + $("#research_input_fill").val();
                }
                else {
                    $(".alert:nth-child(2)").show('fade');
                }
        }
           else {

               $(".alert:nth-child(1)").show('fade');
           }
        }
        else {
            document.location.href = "search?method=" + method + "&value=" + $("#research_input_fill").val();
        }

    });

    //Redirection formulaire newletters
    $("#newsSubmit").click(function () {
        let email = $('#newsEmail').val();
        let checked;
        if($('#offersCheck').is(':checked')){
            checked=1;
        }
        else {
            checked=0;
        }

        document.location.href = "news?email=" + email + "&offer="+checked ;
    });

    //Redirection formulaire book
    $('#bookSubmit').click(function () {
        let firstname = $('.firstname_post').val();
        let name = $('.name_post').val();
        let email = $('.email_post').val();
        //alert(artist+" "+style+" "+date+" "+city+" "+firstname+" "+name+" "+email);
        document.location.href = "book?idConcert=" + idConcert + "&firstName=" + firstname + "&lastName=" + name + "&email=" + email + "";
    });
});

function book(x) {
    idConcert = x;
    //alert(x);
}

function keyup() {
    // Récuperation des états boutton radios
    if ($('#research_input_fill').val().length > 1) {
        $('#button-research').prop('disabled', false);
    } else {
        $('#button-research').prop('disabled', true);
    }
}
function newkeyup() {
    //Deverrouillage du bouton newletters
    if ($('#newsEmail').val().length > 3 && $('#newsEmail').val().includes('@') === true && $('#newsEmail').val().includes('.') === true) {
        $('#newsSubmit').prop('disabled', false);
    } else {
        $('#newsSubmit').prop('disabled', true);
    }
}

function bookkeyup() {
    //Deverrouillage du bouton recherche
    if ($('input[name="firstName"]').val() && $('input[name="lastName"]').val() && $('input[name="mailAdress"]').val() && $('input[name="mailAdress"]').val().includes('@') === true && $('input[name="mailAdress"]').val().includes('.') === true) {
        $('#bookSubmit').prop('disabled', false);
    } else {
        $('#bookSubmit').prop('disabled', true);
    }
}


