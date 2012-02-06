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

    $("#link_new_task").click(function() {
        var link = $(this);
        link.html(link.html() == 'Cancel <span>(press esc)</span>' ? 'New task <span>(ctrl n)</span>' : 'Cancel <span>(press esc)</span>').toggleClass("active");
        $("#new_task").toggle();
        $("#task_name").focus();
        return false;
    });

    if ($("#project-show #new_task").length > 0) {
        bind_n_key();
    }

    function bind_n_key() {
        $(document).keyup(function(e) {
            if (e.keyCode == 78) {
                unbind_key();
                bind_esc_key();
                $("#link_new_task").html("Cancel <span>(press esc)</span>").addClass("active");
                $("#new_task").show();
                $("#task_name").focus();
                return false;
            }
        });
    }

    function bind_esc_key() {
        $(document).keyup(function(e) {
            if (e.keyCode == 27) {
                unbind_key();
                bind_n_key();
                $("#link_new_task").html("New task <span>(press n)</span>").removeClass("active");
                var new_task_form = $('#new_task');
                new_task_form.each (function(){
                    this.reset();
                });
                new_task_form.hide();
                return false;
            };
        });
    }

    function unbind_key() {
        $(document).unbind("keyup");
    }
});
