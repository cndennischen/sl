var clipboard = new Object();

$(init);

function init() {
  //set up toolbox events
  $("#clearBtn").button({ icons: {primary: "ui-icon-trash"} }).click(clear);
  $("#addBtn").button({ icons: {primary: "ui-icon-plusthick"} }).click(add);
  $("#undoBtn").button({ icons: {primary: "ui-icon-arrowreturnthick-1-w"} }).click(undo);
  $("#redoBtn").button({ icons: {primary: "ui-icon-arrowreturnthick-1-e"} }).click(redo);
  $("#pasteBtn").button({ icons: {primary: "ui-icon-clipboard"} }).click(paste);
  $("#renameBtn").button({ icons: {primary: "ui-icon-pencil"} }).click(openRenameDialog);
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
