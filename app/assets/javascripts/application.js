// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
// require turbolinks						//(Note: turbolinks temporarily disabled to allow facebook buttons to load without refresh until FB API fully implemented)
//= require jquery.turbolinks
//= require_tree .


$(document).ready(function(){

  $("#menu_icon_open").click(function(){
  	AnimateRotate("#menu_icon_open", 0, 180, 800);
  	AnimateRotate("#menu_icon_close", 0, 180, 800);
    $("#menu_div").animate({left: "0px" }, 800);
    $("#menu_icon_open").animate({"opacity": "0"}, 800);
    $("#menu_icon_close").delay(100).animate({"opacity": "1"}, 700);
  });

  $("#menu_icon_close").click(function(){
  	AnimateRotate("#menu_icon_open", 180, 0, 625);
  	AnimateRotate("#menu_icon_close", 180, 0, 625);
    $("#menu_div").animate({left: "-426px" }, 800);
    $("#menu_icon_open").animate({"opacity": "1"}, 800);
    $("#menu_icon_close").animate({"opacity": "0"}, 625);
  });

  $("#intro_div").delay(11300).fadeIn(3000);

});


function AnimateRotate(element,start_degree,end_degree,duration){
   var elem = $(element);
   $({deg: start_degree}).animate({deg: end_degree}, {
   duration: duration,
   step: function(now){
      elem.css({
        transform: "rotate("+now+"deg)"
      });
    }
  });
}