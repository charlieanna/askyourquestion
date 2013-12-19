//public/javascripts/jquery.alertfeedback.js
$(function () {
  var alert = $('.alert');
  if (alert.length > 0) {
    alert.show().animate({height: "10%" }, 200);
    window.setTimeout(function() {
      alert.slideUp();
    }, 3000);
  }
});