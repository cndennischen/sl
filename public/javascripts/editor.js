var clipboard = new Object();

$(init);

function init() {
  //set up toolbox events
  $("#clearBtn").button().click(clear);
  $("#addBtn").button().click(add);
  $("#undoBtn").button().click(undo);
  $("#redoBtn").button().click(redo);
  $("#pasteBtn").button().click(paste);
  $("#renameBtn").button().click(openRenameDialog);
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

function paste(widget) {
  frames["canvasFrame"].pasteWidget();
}

function openRenameDialog() {
  $("#renameDialog").dialog("open");
}

function saved() {
  $("#saved").fadeIn("fast").fadeOut("medium");
}
