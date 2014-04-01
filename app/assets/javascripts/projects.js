$(function() {
    var current_task = ""

    $("#project-show li").mousedown(function() {
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

    $("#link_new_task a").click(function() {
        if ($(this).hasClass("active")) {
            hide_new_task_form();
        }
        else {
            show_new_task_form();
        }
        return false;
    });

    if ($("#project-show #new_task").length > 0) {
        bind_n_key();
    }

    function show_new_task_form() {
        $("#link_new_task a").html("Cancel <span>(press esc)</span>").addClass("active");
        $("#new_task").show();
        $("#task_name").focus();
        unbind_key();
        bind_esc_key();
    }

    function hide_new_task_form() {
        $("#link_new_task a").html("New task <span>(press n)</span>").removeClass("active");
        $("#new_task").get(0).reset();
        $("#new_task").hide();
        $("#link_new_task a").focus().blur();
        unbind_key();
        bind_n_key();
    }

    function bind_n_key() {
        $(document).keyup(function(e) {
            if (e.keyCode == 78) show_new_task_form();
        });
    }

    function bind_esc_key() {
        $(document).keyup(function(e) {
            if (e.keyCode == 27) hide_new_task_form();
        });
    }

    function unbind_key() {
        $(document).unbind("keyup");
    }

    $("#user-projects-more").click(function() {
        $("#user-projects li").each(function() {
            if (!$(this).hasClass("active")) {
                $(this).toggle();
            }
        });
    });
});
