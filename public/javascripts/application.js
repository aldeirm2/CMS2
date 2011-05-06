// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// accepts the link tag which is passed in
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
    });
    $("#new_key_term_dialog").dialog({
        modal: true,
        autoOpen: false,
        title: 'Add Key Term'
    });

// more blah blah
});

var addToTopics = function() {
    var result = "";
    var checkedTopics = $(".topic-checkbox:checked");
    $.each(checkedTopics, function(i, topic) {
        if(i == 0) {
            result = result + $(topic).attr('value');
        }
        else {
            result = result + ", " + $(topic).attr('value');
        }
    });
    return result;
};

$(function(){
$(document).load($("#comment_form").submit(function() {
    var ListOfTopics = addToTopics();
    $('#comment_topics').val(ListOfTopics);
    alert($('#comment_topics').val());
    return true;

}));
});
// This function handles style and display changes for each next button click

function handleWizardNext() {

    if (document.getElementById('ButtonNext').name == 'scopes') {

        // Change the button name - we use this to keep track of which step to display on a click

        document.getElementById('ButtonNext').name = 'categories';

        document.getElementById('ButtonPrevious').name = 'cp_description';

        // Disable/enable buttons when reach reach start and review steps

        document.getElementById('ButtonPrevious').disabled = '';

        // Set new step to display and turn off display of current step

        document.getElementById('cp_description').style.display = 'none';

        document.getElementById('scopes').style.display = '';

        // Change background color on header to highlight new step

        document.getElementById('HeaderTableStep2').style.backgroundColor = 'Yellow';

        document.getElementById('HeaderTableStep1').style.backgroundColor = 'Silver';

    }

    else if (document.getElementById('ButtonNext').name == 'categories') {

        // Change the button name - we use this to keep track of which step to display on a click

        document.getElementById('ButtonNext').name = 'lessons';

        document.getElementById('ButtonPrevious').name = 'scopes';

        document.getElementById('scopes').style.display = 'none';

        document.getElementById('categories').style.display = '';

        // Change background color on header to highlight new step

        document.getElementById('HeaderTableStep3').style.backgroundColor = 'Yellow';

        document.getElementById('HeaderTableStep2').style.backgroundColor = 'Silver';

    }

    else if (document.getElementById('ButtonNext').name == 'lessons') {

        // Change the button name - we use this to keep track of which step to display on a click

        document.getElementById('ButtonNext').name = 'key_terms';

        document.getElementById('ButtonPrevious').name = 'categories';

        // Set new step to display and turn off display of current step

        document.getElementById('categories').style.display = 'none';

        document.getElementById('lessons').style.display = '';

        // Change background color on header to highlight new step

        document.getElementById('HeaderTableStep4').style.backgroundColor = 'Yellow';

        document.getElementById('HeaderTableStep3').style.backgroundColor = 'Silver';

    }

    else if (document.getElementById('ButtonNext').name == 'key_terms') {

        // Change the button name - we use this to keep track of which step to display on a click

        document.getElementById('ButtonNext').name = '';

        document.getElementById('ButtonPrevious').name = 'lessons';

        // Disable/enable buttons when reach reach start and review steps

        document.getElementById('ButtonNext').disabled = 'disabled';



        // Set new step to display and turn off display of current step

        document.getElementById('lessons').style.display = 'none';

        document.getElementById('key_terms').style.display = '';

        // Change background color on header to highlight new step

        document.getElementById('HeaderTableStep5').style.backgroundColor = 'Yellow';

        document.getElementById('HeaderTableStep4').style.backgroundColor = 'Silver';

    }

}


// This function handles style and display changes for each previous button click

function handleWizardPrevious() {

    if (document.getElementById('ButtonPrevious').name == 'cp_description') {

        // Change the button name - we use this to keep track of which step to display on a click

        document.getElementById('ButtonNext').name = 'scopes';

        document.getElementById('ButtonPrevious').name = '';

        // Disable/enable buttons when reach reach start and review steps

        document.getElementById('ButtonPrevious').disabled = 'disabled';

        // Set new step to display and turn off display of current step

        document.getElementById('scopes').style.display = 'none';

        document.getElementById('cp_description').style.display = '';

        // Change background color on header to highlight new step

        document.getElementById('HeaderTableStep1').style.backgroundColor = 'Yellow';

        document.getElementById('HeaderTableStep2').style.backgroundColor = 'Silver';

    }

    else if (document.getElementById('ButtonPrevious').name == 'scopes') {

        // Change the button name - we use this to keep track of which step to display on a click

        document.getElementById('ButtonNext').name = 'categories';

        document.getElementById('ButtonPrevious').name = 'cp_description';

        // Set new step to display and turn off display of current step

        document.getElementById('categories').style.display = 'none';

        document.getElementById('scopes').style.display = '';

        // Change background color on header to highlight new step

        document.getElementById('HeaderTableStep2').style.backgroundColor = 'Yellow';

        document.getElementById('HeaderTableStep3').style.backgroundColor = 'Silver';

    }

    else if (document.getElementById('ButtonPrevious').name == 'categories') {

        // Change the button name - we use this to keep track of which step to display on a click

        document.getElementById('ButtonNext').name = 'lessons';

        document.getElementById('ButtonPrevious').name = 'scopes';

        // Set new step to display and turn off display of current step

        document.getElementById('lessons').style.display = 'none';

        document.getElementById('categories').style.display = '';

        // Change background color on header to highlight new step

        document.getElementById('HeaderTableStep3').style.backgroundColor = 'Yellow';

        document.getElementById('HeaderTableStep4').style.backgroundColor = 'Silver';

    }

    else if (document.getElementById('ButtonPrevious').name == 'lessons') {

        // Change the button name - we use this to keep track of which step to display on a click

        document.getElementById('ButtonNext').name = 'key_terms';

        document.getElementById('ButtonPrevious').name = 'categories';

        // Disable/enable buttons when reach reach start and review steps

        document.getElementById('ButtonNext').disabled = '';


        // Set new step to display and turn off display of current step

        document.getElementById('key_terms').style.display = 'none';

        document.getElementById('lessons').style.display = '';

        // Change background color on header to highlight new step

        document.getElementById('HeaderTableStep4').style.backgroundColor = 'Yellow';

        document.getElementById('HeaderTableStep5').style.backgroundColor = 'Silver';

    }

}