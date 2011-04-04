// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// accpets the link tag which is passed in
function remove_fields(link) {
    $(link).prev('input[type=hidden]').val("1");
    $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    $(link).parent().before(content.replace(regexp, new_id));
}


$(function () {
    $('input[id=date]').datepicker();
});


$(function() {
// blah blah

    $("#term_link").click(function() {
        console.log('clicked');
        $("#new_key_term_dialog").dialog('open');
    })
    $("#new_key_term_dialog").dialog({
        modal: true,
        autoOpen: false,
        title: 'Add Key Term'
    })

// more blah blah
})


// This function handles style and display changes for each next button click

function handleWizardNext() {

    if (document.getElementById('ButtonNext').name == 'Step2') {

        // Change the button name - we use this to keep track of which step to display on a click

        document.getElementById('ButtonNext').name = 'Step3';

        document.getElementById('ButtonPrevious').name = 'Step1';

        // Disable/enable buttons when reach reach start and review steps

        document.getElementById('ButtonPrevious').disabled = '';

        // Set new step to display and turn off display of current step

        document.getElementById('Step1').style.display = 'none';

        document.getElementById('Step2').style.display = '';

        // Change background color on header to highlight new step

        document.getElementById('HeaderTableStep2').style.backgroundColor = 'Yellow';

        document.getElementById('HeaderTableStep1').style.backgroundColor = 'Silver';

    }

    else if (document.getElementById('ButtonNext').name == 'Step3') {

        // Change the button name - we use this to keep track of which step to display on a click

        document.getElementById('ButtonNext').name = 'Step4';

        document.getElementById('ButtonPrevious').name = 'Step2';

        document.getElementById('Step2').style.display = 'none';

        document.getElementById('Step3').style.display = '';

        // Change background color on header to highlight new step

        document.getElementById('HeaderTableStep3').style.backgroundColor = 'Yellow';

        document.getElementById('HeaderTableStep2').style.backgroundColor = 'Silver';

    }

    else if (document.getElementById('ButtonNext').name == 'Step4') {

        // Change the button name - we use this to keep track of which step to display on a click

        document.getElementById('ButtonNext').name = 'Step5';

        document.getElementById('ButtonPrevious').name = 'Step3';

        // Set new step to display and turn off display of current step

        document.getElementById('Step3').style.display = 'none';

        document.getElementById('Step4').style.display = '';

        // Change background color on header to highlight new step

        document.getElementById('HeaderTableStep4').style.backgroundColor = 'Yellow';

        document.getElementById('HeaderTableStep3').style.backgroundColor = 'Silver';

    }

    else if (document.getElementById('ButtonNext').name == 'Step5') {

        // Change the button name - we use this to keep track of which step to display on a click

        document.getElementById('ButtonNext').name = '';

        document.getElementById('ButtonPrevious').name = 'Step4';

        // Disable/enable buttons when reach reach start and review steps

        document.getElementById('ButtonNext').disabled = 'disabled';

        document.getElementById('SubmitFinal').disabled = '';

        // Set new step to display and turn off display of current step

        document.getElementById('Step4').style.display = 'none';

        document.getElementById('Step5').style.display = '';

        // Change background color on header to highlight new step

        document.getElementById('HeaderTableStep5').style.backgroundColor = 'Yellow';

        document.getElementById('HeaderTableStep4').style.backgroundColor = 'Silver';

        // Load table elements for final review step

        loadStep5Review();

    }

}


// This function handles style and display changes for each previous button click

function handleWizardPrevious() {

    if (document.getElementById('ButtonPrevious').name == 'Step1') {

        // Change the button name - we use this to keep track of which step to display on a click

        document.getElementById('ButtonNext').name = 'Step2';

        document.getElementById('ButtonPrevious').name = '';

        // Disable/enable buttons when reach reach start and review steps

        document.getElementById('ButtonPrevious').disabled = 'disabled';

        // Set new step to display and turn off display of current step

        document.getElementById('Step2').style.display = 'none';

        document.getElementById('Step1').style.display = '';

        // Change background color on header to highlight new step

        document.getElementById('HeaderTableStep1').style.backgroundColor = 'Yellow';

        document.getElementById('HeaderTableStep2').style.backgroundColor = 'Silver';

    }

    else if (document.getElementById('ButtonPrevious').name == 'Step2') {

        // Change the button name - we use this to keep track of which step to display on a click

        document.getElementById('ButtonNext').name = 'Step3';

        document.getElementById('ButtonPrevious').name = 'Step1';

        // Set new step to display and turn off display of current step

        document.getElementById('Step3').style.display = 'none';

        document.getElementById('Step2').style.display = '';

        // Change background color on header to highlight new step

        document.getElementById('HeaderTableStep2').style.backgroundColor = 'Yellow';

        document.getElementById('HeaderTableStep3').style.backgroundColor = 'Silver';

    }

    else if (document.getElementById('ButtonPrevious').name == 'Step3') {

        // Change the button name - we use this to keep track of which step to display on a click

        document.getElementById('ButtonNext').name = 'Step4';

        document.getElementById('ButtonPrevious').name = 'Step2';

        // Set new step to display and turn off display of current step

        document.getElementById('Step4').style.display = 'none';

        document.getElementById('Step3').style.display = '';

        // Change background color on header to highlight new step

        document.getElementById('HeaderTableStep3').style.backgroundColor = 'Yellow';

        document.getElementById('HeaderTableStep4').style.backgroundColor = 'Silver';

    }

    else if (document.getElementById('ButtonPrevious').name == 'Step4') {

        // Change the button name - we use this to keep track of which step to display on a click

        document.getElementById('ButtonNext').name = 'Step5';

        document.getElementById('ButtonPrevious').name = 'Step3';

        // Disable/enable buttons when reach reach start and review steps

        document.getElementById('ButtonNext').disabled = '';

        document.getElementById('SubmitFinal').disabled = 'disabled';

        // Set new step to display and turn off display of current step

        document.getElementById('Step5').style.display = 'none';

        document.getElementById('Step4').style.display = '';

        // Change background color on header to highlight new step

        document.getElementById('HeaderTableStep4').style.backgroundColor = 'Yellow';

        document.getElementById('HeaderTableStep5').style.backgroundColor = 'Silver';

    }

}