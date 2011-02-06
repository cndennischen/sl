$(init);

function init() {
  //set up toolbox events
  $("#clearBtn").button().click(clear);
  $("#addBtn").button().click(add);
  $("#undoBtn").button().click(undo);
  $("#redoBtn").button().click(redo);
}

function clear() {
  frames["canvasFrame"].action();
  //clear the canvas
  frames["canvasFrame"].clear();
}

function add() {
  frames["canvasFrame"].action();
  //add the selected type of widget to the canvas
  frames["canvasFrame"].add($("#controlBox").val(), $("#controlBox option:selected").text(), "");
  frames["canvasFrame"].init();
}

function undo() {
  //undo last action
  frames["canvasFrame"].undo();
}

function redo() {
  //redo last undo action
  frames["canvasFrame"].redo();
}