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



//////////////////////////// MENU DRAWER ///////////////////////////// 

$(document).ready(function(){

  $("#intro_div").delay(11300).fadeIn(3000);

  //nav menu
	$("#nav_menu_icon_open").click(function(){
		AnimateRotate("#nav_menu_icon_open", 0, 180, 600);
		AnimateRotate("#nav_menu_icon_close", 0, 180, 600);
	  $("#nav_menu_div").animate({left: "0px" }, 600);
	  $("#nav_menu_icon_open").animate({"opacity": "0" }, 600);
	  $("#nav_menu_icon_close").delay(75).animate({"opacity": "1"}, 600);
	});
	$("#nav_menu_icon_close").click(function(){
		AnimateRotate("#nav_menu_icon_open", 180, 0, 500);
		AnimateRotate("#nav_menu_icon_close", 180, 0, 500);
	  $("#nav_menu_div").animate({left: -$("#nav_menu_div").width() }, 600);
	  $("#nav_menu_icon_open").animate({"opacity": "1" }, 600);
	  $("#nav_menu_icon_close").animate({"opacity": "0"}, 500);
	});

	//profile menu
	$("#profile_menu_icon_open, .header_right.user_image").click(function(){
		AnimateRotate("#profile_menu_icon_open", 0, -180, 600);
		AnimateRotate("#profile_menu_icon_close", 0, -180, 600);
	  $("#profile_menu_div").animate({right: "0px" }, 600);
	  $("#profile_menu_icon_open").animate({"opacity": "0" }, 600);
	  $("#profile_menu_icon_close").delay(75).animate({"opacity": "1"}, 600);
	  $(".profile_menu_user_name").delay(450).animate({"opacity": "1"}, 400);
	});
	$("#profile_menu_icon_close").click(function(){
		AnimateRotate("#profile_menu_icon_open", -180, 0, 500);
		AnimateRotate("#profile_menu_icon_close", -180, 0, 500);
	  $("#profile_menu_div").animate({right: -$("#profile_menu_div").width() }, 600);
	  $("#profile_menu_icon_open").animate({"opacity": "1" }, 600);
	  $("#profile_menu_icon_close").animate({"opacity": "0"}, 500);
	  $(".profile_menu_user_name").animate({"opacity": "0"}, 100);
	});

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



