var originalWidth;
var originalHeigh;

$(init);

function init () {
	//set up widgets and event handlers
	$("#increaseHBtn").click(increaseCanvasH);
	$("#reduceHBtn").click(reduceCanvasH);
	$("#increaseWBtn").click(increaseCanvasW);
	$("#reduceWBtn").click(reduceCanvasW);
	$("#resetCanvasBtn").click(resetCanvas);
	$("#zoomInBtn").click(zoomIn);
	$("#zoomOutBtn").click(zoomOut);
	//get the original canvas size
	originalWidth = $("#canvas").width();
	originalHeigh = $("#canvas").height();
	//load the saved state from localStorage
  setData(JSON.parse(localStorage["data"]));
}

function add(className, text, style) {
  //add the widget to the canvas
  $("#canvas").append("<div class='widget " + className + "' style='" + style + "'><div class='text'>" + text + "</div></div>");
}

function setData(data) {
	$.each(data, function (index, value) {
    //add the widget to the canvas
    add(value["class"], value["text"], value["style"]);
  });
}

function increaseCanvasH() {
	$("#canvas").height($("#canvas").height() + 10);
}

function reduceCanvasH() {
	$("#canvas").height($("#canvas").height() - 10);
}
function increaseCanvasW() {
	$("#canvas").width($("#canvas").width() + 10);
}

function reduceCanvasW() {
	$("#canvas").width($("#canvas").width() - 10);
}

function zoomIn() {
	if (parseFloat($("#canvas").css("zoom")) < 4) {
		$("#canvas").css("zoom", parseFloat($("#canvas").css("zoom")) + 0.25);
	}
}

function zoomOut() {
	if (parseFloat($("#canvas").css("zoom")) > 0.25) {
		$("#canvas").css("zoom", parseFloat($("#canvas").css("zoom")) - 0.25);
	}
}

function resetCanvas() {
	$("#canvas").width(originalWidth);
	$("#canvas").height(originalHeigh);
	$("#canvas").css("zoom", "100%");
}
