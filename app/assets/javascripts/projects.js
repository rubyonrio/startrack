$(function() {
    var current_task = ""

    $( "#scheduled li" ).draggable({
	connectToSortable: "#current ul",
        helper: "#scheduled ul",
	revert: "invalid",
        appendTo: "body",
        start: function(){
            current_task = $(this).attr('id');
        }
    });

    $("#current ul").droppable({
        drop: function() {
            $.ajax({
                type: "POST",
                url: '/tasks/"+current_task+"/change_status/',
                data: { _method:'PUT', page : {...} },
                dataType: 'json',
                success: function(msg) {
                    alert("Data Saved: ");
                }
            });
        }
    }).sortable({
        placeholder: "ui-sortable-placeholder"
    });

});