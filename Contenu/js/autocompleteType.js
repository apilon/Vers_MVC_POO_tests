$(function() {
    
    //autocomplete
    $("#auto").autocomplete({
        source: "index.php?action=quelsTypes",
        minLength: 1
    });                

});



