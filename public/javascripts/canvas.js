var undoStack = [];
var redoStack = [];

$(document).ready(load);

$(init);

function init() {
  /* -- set up widgets and event handlers -- */
  
  //preserve aspect ratio when resizing
  $(".radio, .checkbox")
    .resizable({
  	  aspectRatio: 1/1
    });
  
  //resizable horizontal only
  $(".textbox")
    .resizable({
        handles: "e, w"
    });
  
  //all widgets
  $(".widget")
    .draggable({
      grid: [ 10, 10 ],
      start: action,
      stop: save
    })
    .resizable({
      minHeight: 20,
      minWidth: 20,
      grid: 10,
      start: action,
      stop: save
    })
    .contextMenu("contextMenu", {
      bindings: {
        "edit": editWidget,
        "delete": delWidget,
        "front": front,
        "forward": forward,
        "backward": backward,
        "back": back
      }
    });
    
  //not resizable
  $(".label, .paragraph, .radio, .checkbox, .link, .menu")
    .resizable("destroy");
  
  //z-index
  order();
}

function editWidget(widget) {
  //get widget's current text
  var currentText = $(widget).children(".text").html();
  //promt user to enter new text
  newText = prompt("Please enter new text", currentText);
  //check if null
  if (newText == null)
    return;
  action();
  //set the widget's text
  $(widget).children(".text").html(newText);
  save();
}

function delWidget(widget) {
  action();
  //delete widget
  $(widget).remove();
  save();
}

function front(widget) {
  action();
  //bring to front
  $(widget).appendTo($("#canvas"));
  //re-order widgets
  order();
	save();
}

function forward(widget) {
  action();
  //bring forward
  $(widget).insertAfter($(widget).next(".widget"));
  //re-order widgets
  order();
	save();
}

function backward(widget) {
  action();
  //send backward
  $(widget).insertBefore($(widget).prev(".widget"));
  //re-order widgets
  order();
	save();
}

function back(widget) {
  action();
  //send to back
  $(widget).prependTo("#canvas");
  //re-order widgets
  order();
	save();
}
function order() {
  //order widgets
  $(".widget").each(function(index) {
    $(this).css("z-index", index);
  });
}
function clear() {
  $("#canvas").empty();
}
function add(className, text, style) {
  //add the widget to the canvas
  $("#canvas").append("<div class=\"widget " + className + "\" style=\"" + style + "\"><div class=\"text\">" + text + "</div></div>");
}
function action() {
  //add the current state to the undo stack
  undoStack.push(getData());
}
function undo() {
  //check if there's anything to undo
  if(undoStack.length == 0)
    return;
  //add the current state to the redo stack
  redoStack.push(getData());
  //get the previous state
  var state = undoStack.pop();
  //restore to the previous state
  setData(state);
	save();
}
function redo() {
  //check if there's anything to redo
  if(redoStack.length == 0)
    return;
  //add the current state to the undo stack
  undoStack.push(getData());
  //get the next state
  var state = redoStack.pop();
  //restore to the next state
  setData(state);
	save();
}
function save(name) {
  //get the id of the sketch from the url
  id = parent.document.location.href.split("/").pop();
  //save the current state
  $.ajax({
      url: "/save",
      type: "POST",
      data: ({ id: id, data: JSON.stringify(getData()) }),
      success: function() {
        parent.saved();
      }
  });
}
function load() {
  //load the saved state from localStorage
  setData(JSON.parse(localStorage["data"]));
  //clear the undo and redo stacks
  undoStack = [];
  redoStack = [];
}
function getData() {
	//returns the contents of the canvas in JSON format
  var widgets = {};
  $(".widget").each(function(i) {
    var widget = {};
    //get the widget's information
    widget["class"] = $(this).attr('class').split(' ')[1];
    widget["text"] = $(this).children(".text").html();
    widget["style"] = $(this).attr("style");
    //add the widget to the list
    widgets[i] = widget;
  });
  return widgets;
}
function setData(data) {
  //first clear the canvas
  clear();
  //iterate through the saved widgets
  $.each(data, function(index, value) {
    //add the widget to the canvas
    add(value["class"], value["text"], value["style"]);
  });
  init();
}
