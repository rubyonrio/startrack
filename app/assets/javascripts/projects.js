$(function() {
    var current_task = ""

    $("li").mousedown(function() {
        project = document.location.pathname.replace("/projects/","");
        current_task = $(this).attr('id').replace("task-","");
    });

    $("#todo ul, #scheduled ul, #current ul, #done ul").sortable({
        placeholder: "ui-sortable-placeholder",
        connectWith: ".ui-sortable"
    });

    $("#todo ul").droppable({
        drop: function() {
            $.get('/projects/'+project+'/tasks/'+current_task+'/change_status/'+1)
        }
    });

    $("#scheduled ul").droppable({
        drop: function() {
            $.get('/projects/'+project+'/tasks/'+current_task+'/change_status/'+2)
        }
    });

    $("#current ul").droppable({
        drop: function() {
            $.get('/projects/'+project+'/tasks/'+current_task+'/change_status/'+3)
        }
    });

    $("#done ul").droppable({
        drop: function() {
            $.get('/projects/'+project+'/tasks/'+current_task+'/change_status/'+4)
        }
    });

});