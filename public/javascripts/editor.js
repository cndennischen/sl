$(init);

function init() {
  //set up toolbox events
  $("#clearBtn").button().click(clear);
  $("#addBtn").button().click(add);
  $("#undoBtn").button().click(undo);
  $("#redoBtn").button().click(redo);
  $("#renameBtn").button().click(rename);
  //set up rename dialog
  $("#renameDialog").dialog({
    autoOpen: false,
    modal: true,
    title: "Rename Sketch"
  });
}

function clear() {
  frames["canvasFrame"].action();
  //clear the canvas
  frames["canvasFrame"].clear();
	frames["canvasFrame"].save();
}

function add() {
  frames["canvasFrame"].action();
  //add the selected type of widget to the canvas
  frames["canvasFrame"].add($("#controlBox").val(), $("#controlBox option:selected").text(), "");
  frames["canvasFrame"].init();
	frames["canvasFrame"].save();
}

function undo() {
  //undo last action
  frames["canvasFrame"].undo();
}

function redo() {
  //redo last undo action
  frames["canvasFrame"].redo();
}

function rename() {
  $("#renameDialog").dialog("open");
}

function validateRename() {
  if ($("#newTxt").val() == "") {
    $("#newTxt").addClass("field_with_errors");
    $("#validationErrors").hide();
    $("#nullErrors").show();
    return false;
  } else if (!$("#newTxt").val().match(/^[a-zA-Z0-9_-]+$/)) {
    $("#newTxt").addClass("field_with_errors");
    $("#nullErrors").hide();
    $("#validationErrors").show();
    return false;
  } else {
    create();
    return true;
  }
}
