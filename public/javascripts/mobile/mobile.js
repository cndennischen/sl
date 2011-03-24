$(document).bind("mobileinit", function(){
  $.mobile.ajaxEnabled = false;
});

$(init);

function init() {
  //fade out flashes
  setTimeout(function () {
    $("#flash_notice, #flash_error, #flash_alert").fadeOut(2000);
  }, 2000);
  
  //set up widgets and event handlers
  $("#backBtn").click(function() {
  	history.go(-1);
  });
}
