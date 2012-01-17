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

    $("body").keypress(function(e) {
        if (e.keyCode == 110) {
            $("#link_new_task").html("Cancel <span>(press esc)</span>").addClass("active");
            $("#new_task").show();
            $("#task_name").focus();
            return false;
        };
    });

    $(document).keyup(function(e) {
        if (e.keyCode == 27) {
            $("#link_new_task").html("New task <span>(press n)</span>").removeClass("active");
            $("#new_task").hide();
            return false;
        };
    });

    $("#link_new_task").click(function() {
        var link = $(this);
        link.html(link.html() == 'Cancel <span>(press esc)</span>' ? 'New task <span>(press n)</span>' : 'Cancel <span>(press esc)</span>').toggleClass("active");
        $("#new_task").toggle();
        $("#task_name").focus();
        return false;
    });

});