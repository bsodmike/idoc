var wmd_options = {
  output : "Markdown"    
};

$(document).ready(function() {
    $('#menu_container > ul.menu').treeview({
        persist : "cookie",
        collapsed : true,
        unique : true
    });
});

$(document).ready(function() {
    $('#menu_editor').tree({
        types : {
            "default" : {
                draggable : false
            },
            "editable" : {
                draggable : true
            }
        },
        ui : {
            theme_name : "classic",
            theme_path : "/themes/classic/style.css"
        }
    });
    $('fieldset.positioning').hide();
    $('fieldset.positioning_tree').show();
});