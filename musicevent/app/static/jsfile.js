let research;
$(document).ready(function() {
	if($('input[type=radio][name=inlineRadioOptions]').is(":checked"){
		$('#button-addon2').prop('disabled', false);
	});
    $('input[type=radio][name=inlineRadioOptions]').change(function () {
        $('#button-addon2').prop('disabled', false);
        if ($('#inlineRadio1').is(':checked')) {
            research = 1;
        } else if ($('#inlineRadio2').is(':checked')) {
            //alert("BY CITY");
            research = 2;
        } else if ($('#inlineRadio3').is(':checked')) {
            //alert("BY DATE");
            research = 3;
        }
    });
    $("#newsEmail").blur(function () {
        if (!$(this).val()) {
            $('#newsSubmit').prop('disabled', true);
        } else {
            $('#newsSubmit').prop('disabled', false);
        }
    });



    $('input[name="firstName"]').blur(function () {
        if($('input[name="firstName"]').val() && $('input[name="lastName"]').val() && $('input[name="mailAdress"]').val() ){
            $('#bookSubmit').prop('disabled', false);
        }
        else {
            $('#bookSubmit').prop('disabled', true);
        }
    });
    $('input[name="lastName"]').blur(function () {
        if($('input[name="firstName"]').val() && $('input[name="lastName"]').val() && $('input[name="mailAdress"]').val() ){
            $('#bookSubmit').prop('disabled', false);
        }
        else {
            $('#bookSubmit').prop('disabled', true);
        }
    });
    $('input[name="mailAdress"]').blur(function () {
        if($('input[name="firstName"]').val() && $('input[name="lastName"]').val() && $('input[name="mailAdress"]').val() ){
            $('#bookSubmit').prop('disabled', false);
        }
        else {
            $('#bookSubmit').prop('disabled', true);
        }
    });
    
});
