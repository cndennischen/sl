var clipboard = new Object();

$(document).ready(load);


function load() {
  //save before closing
  window.onbeforeunload = function() {
    frames["canvasFrame"].save(true);
  }
  //set up toolbox events
  $("#clearBtn").button({
    icons: {
      primary: "ui-icon-trash"
    }
  }).click(clear);
  $("#addBtn").button({
    icons: {
      primary: "ui-icon-plusthick"
    }
  }).click(add);
  $("#undoBtn").button({
    icons: {
      primary: "ui-icon-arrowreturnthick-1-w"
    }
  }).click(undo);
  $("#redoBtn").button({
    icons: {
      primary: "ui-icon-arrowreturnthick-1-e"
    }
  }).click(redo);
  $("#pasteBtn").button({
    icons: {
      primary: "ui-icon-clipboard"
    }
  }).click(paste);
  $("#renameBtn").button({
    icons: {
      primary: "ui-icon-pencil"
    }
  }).click(openRenameDialog);
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
  var type = $("#controlBox").val();
  var text = $("#controlBox option:selected").text();
  //only make default text if it's not a checkbox or radio button, bec. they don't have text
  if (type == "checkbox" || type == "radio") {
    text = "";
  }
  frames["canvasFrame"].add(type, text, "");
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

function exportSketch(id, format) {
  frames["canvasFrame"].save(true);
  window.location = "/export/" + id + "/" + format;
}

function saved() {
  $("#saved").fadeIn("fast").fadeOut("medium");
}

function saveFailed() {
  $("#saveFailed").fadeIn("fast").fadeOut("medium");
}
