// Application-wide functions

// Initialize jQuery UI Elements
$(document).ready( function() {
    $("#tabs").tabs();

});


function next_tab() {
    var $tabs = $('#tabs').tabs();

    // In case we're already on the last tab
    if($tabs.tabs('option', 'selected') == ( $tabs.tabs('length') - 1) ) { 
        return false;
    }   

    $tabs.tabs('select', $tabs.tabs('option', 'selected') + 1); 
    return false;
}

function prev_tab() {
    var $tabs = $('#tabs').tabs();

    // In case we're already on the first tab
    if($tabs.tabs('option', 'selected') == 0) {
        return false;
    }   

    $tabs.tabs('select', $tabs.tabs('option', 'selected') - 1); 
    return false;
}

