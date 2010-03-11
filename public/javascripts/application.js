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