$(document).ready(function() {
    $('#menu_container > ul.menu').treeview({
        persist : "location",
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
        },
        callback : {
            onmove : function(node, ref_node, type, tree, rb) {
                var position_field = $("#documentation_page_position")[0];
                var parent_select = $("#documentation_page_parent_id");
                var previous_item = node.previousElementSibling;
                var new_parent = node.parentNode.parentNode;
                var new_parent_id = "";
                var position = 1;
                if (previous_item) {
                    position = parseInt(previous_item.getAttribute("data-position")) + 1;
                }
                position_field.value = position;
                if (new_parent.nodeName == "LI") {
                    new_parent_id = new_parent.getAttribute("data-id");
                }
                parent_select.selectOptions(new_parent_id);

            }
        }
    });
    $('fieldset.positioning').hide();
    $('fieldset.positioning_tree').show();
    $('#documentation_page_title').change(function(event) {
        $("#current_item > a")[0].innerHTML = event.target.value;
    });
});

$(document).ready(function() {
    $('#tree_editor').tree({
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
        },
        callback : {
            onmove : function(node, ref_node, type, tree, rb) {
                var node_name = node.getAttribute("data-name");
                var position_field = $("#documentation_tree_documentation_page_" + node_name + "_position")[0];
                var parent_select = $("#documentation_tree_documentation_page_" + node_name + "_parent_id");
                var previous_item = node.previousElementSibling;
                var next_item = node.nextElementSibling;
                var new_parent = node.parentNode.parentNode;
                var new_parent_id = "";
                var position = 1;
                if (previous_item) {
                    position = parseInt(previous_item.getAttribute("data-position")) + 1;
                }
                var next_position = position + 1
                while (next_item) {
                  var next_position_field = $("#documentation_tree_documentation_page_" + next_item.getAttribute("data-name") + "_position")[0];
                  next_position_field.value = next_position;
                  next_position = next_position + 1;
                  next_item = next_item.nextElementSibling;
                }
                position_field.value = position;
                if (new_parent.nodeName == "LI") {
                    new_parent_id = new_parent.getAttribute("data-id");
                }
                parent_select.selectOptions(new_parent_id);

            }
        }
    });
    $('#html_editor').hide();
    $('#tree_editor').show();
});

$(document).ready(function() {
    var form = $('#header_login');
    var button = $('#header_login_button');
    form.hide();
    button.show();
    button.click(function() {
        form.show();
        $("#header_buttons").hide();
    });
});
