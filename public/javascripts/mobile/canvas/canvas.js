$(init);

function init () {
	//set up widgets and event handlers
	$("#enlargeBtn").click(enlargeCanvas);
	$("#reduceBtn").click(reduceCanvas);
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

function enlargeCanvas() {
	//make the canvas 10 pixels larger
	$("#canvas").height($("#canvas").height() + 10);
}

function reduceCanvas () {
	//make the canvas 10 pixelse larger
	$("#canvas").height($("#canvas").height() - 10);
}
