$(init);

function init() {
  //fade out flashes
  setTimeout(function () {
    $("#flash_notice, #flash_error, #flash_alert").fadeOut(2000);
  }, 5000);
}