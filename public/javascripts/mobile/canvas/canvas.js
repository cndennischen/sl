$(init);

function init () {
	//load the saved state from localStorage
  setData(JSON.parse(localStorage["data"]));
}

function add(className, text, style) {
  //add the widget to the canvas
  $("#canvas").append("<div class='widget " + className + "' style='" + style + "'><div class='text'>" + text + "</div></div>");
}

function setData (data) {
	$.each(data, function (index, value) {
    //add the widget to the canvas
    add(value["class"], value["text"], value["style"]);
  });
}
