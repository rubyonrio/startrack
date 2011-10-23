remove_fields = function(file_id) {
    var divFile = $("#"+file_id);
    divFile.find('input[id*="_destroy"]').val("1");
    divFile.hide();
};

add_fields = function(association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g")
    $("#task_files").prepend(content.replace(regexp, new_id));
};

toggleTaskDescription = function(pThis) {

    if($(pThis).attr("class") == "mais") {
        $(pThis).removeClass("mais");
        $(pThis).addClass("menos");
        $(pThis).html("<img src='/assets/bt_menos.gif'/>");
    } else {
        $(pThis).addClass("mais");
        $(pThis).removeClass("menos");
        $(pThis).html("<img src='/assets/bt_mais.gif'/>");
    }
    $(pThis).parent().parent().find(".task_file_description").toggle("slow");
  };