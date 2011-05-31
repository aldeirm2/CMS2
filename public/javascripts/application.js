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

$(function() {
    $("#term_link").click(function() {
        console.log('clicked');
        $("#new_key_term_dialog").dialog('open');
    });
    $("#new_key_term_dialog").dialog({
        modal: true,
        autoOpen: false,
        title: 'Add Key Term'
    });
});

// Method which returns a string value of the topics selected by a user when leaving a comment.
var commentTopics = function() {
    var result = "";
    var checkedTopics = $(".topic_checkbox:checked");
    $.each(checkedTopics, function(i, topic) {
        if (i == 0) {
            result = result + $(topic).attr('value');
        }
        else {
            result = result + ", " + $(topic).attr('value');
        }
    });
    return result;
};

// Method to add the selected topics of the user when leaving a comment on a CP.
$(function() {
    $(document).load($("#comment_form").submit(function() {
        var ListOfTopics = commentTopics();
        $('#comment_topics').val(ListOfTopics);
        return true;

    }));
});

// Method to ensure that a user has selected a user to send a message to
$(function() {
    $(document).load($("#new_message").submit(function() {

        if ($('#message_to_id').val() == '') {
            alert('Please Select a User to send to');
            return false;
        }
        else {

            return true;
        }
    }));
});

// Method to ensure that a title has been entered for a CP before its created.
$(function() {
    $(document).load($("#new_critical_process").submit(function() {

        if ($('#critical_process_cp_title').val() == '') {
            alert('CP must have a title before its created');
            return false;
        }
        else {

            return true;
        }
    }));
});



// This function handles style and display changes for each next button click

function wizardNext() {

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

function wizardPrevious() {

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

// Atuocomplete method used to display the usernames to the user which were return from the controller method 'query'
$(function() {
    var cache = {},
            lastXhr;
    $("#username").autocomplete({
        minLength: 1,
        source: function(request, response) {
            var term = request.term;
            if (term in cache) {
                response(cache[ term ]);
                return;
            }

            lastXhr = $.getJSON("/usernames", request, function(data, status, xhr) {
                cache[ term ] = data;
                if (xhr === lastXhr) {
                    response(data);
                }
            });
        },
        select: function(event, ui) {
            $('#message_to_id').val(ui.item.id);
        },
        change: function(event, ui) {
            if ($('#username').val().length == 0) {
                $('#message_to_id').val('');
            }
        }

    });
});