$(function() {
    var current_task = ""

    $("li").draggable({
	connectToSortable: "ul",
        helper: "ul",
        appendTo: ".status-pane ul",
        start: function(){
            current_task = $(this).attr('id').replace("task-","");
        }
    });

    $("ul").sortable({
        placeholder: "ui-sortable-placeholder"
    });

    $("#todo ul").droppable({
        drop: function() {
            $.get('/tasks/'+current_task+'/change_status/'+1)
        }
    });

    $("#scheduled ul").droppable({
        drop: function() {
            $.get('/tasks/'+current_task+'/change_status/'+2)
        }
    });

    $("#current ul").droppable({
        drop: function() {
            $.get('/tasks/'+current_task+'/change_status/'+3)
        }
    });

    $("#done ul").droppable({
        drop: function() {
            $.get('/tasks/'+current_task+'/change_status/'+4)
        }
    });

});