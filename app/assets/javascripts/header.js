$(document).ready(function(){

  $("#intro_div").delay(11300).fadeIn(3000);

  //nav menu
	$("#nav_menu_icon_open").click(function(){
		AnimateRotate("#nav_menu_icon_open", 0, 180, 600);
		AnimateRotate("#nav_menu_icon_close", 0, 180, 600);
	  $("#nav_menu_div").animate({left: "0px" }, 600);
	  $("#nav_menu_icon_open").animate({"opacity": "0" }, 600);
	  $("#nav_menu_icon_close").delay(75).animate({"opacity": "1"}, 600);
	  $("#nav_menu_clickaway_skin").show();
	});
	$("#nav_menu_icon_close, #nav_menu_clickaway_skin").click(function(){
		AnimateRotate("#nav_menu_icon_open", 180, 0, 500);
		AnimateRotate("#nav_menu_icon_close", 180, 0, 500);
	  $("#nav_menu_div").animate({left: -$("#nav_menu_div").width() }, 600);
	  $("#nav_menu_icon_open").animate({"opacity": "1" }, 600);
	  $("#nav_menu_icon_close").animate({"opacity": "0"}, 500);
	  $("#nav_menu_clickaway_skin").hide();
	});

	//profile menu
	$("#profile_menu_icon_open").click(function(){
		OpenProfileMenu()
	});
	$("#profile_menu_icon_close, #profile_menu_clickaway_skin").click(function(){
		CloseProfileMenu()
	});
	$("#profile_menu_user_image_div").click(function(){
		(!$("#profile_menu_div").hasClass("open")) ? OpenProfileMenu() : CloseProfileMenu();
	});

	//posts menu
	$("#posts_menu_icon, #posts_menu_dropdown_clickaway_skin").click(function(){
		if ($("#posts_menu_dropdown").hasClass("closed")) {
			$("#posts_menu_dropdown").css("opacity", "1");		//(closed dropdown div is hidden so not visible on overscroll bounce; this makes visible when opened)
			AnimateRotate("#posts_menu_icon", 0, 180, 600);
		  $("#posts_menu_dropdown").animate({top: "76px" }, 600);
		  $("#posts_menu_dropdown").removeClass("closed");
		  $("#posts_menu_dropdown").addClass("open");
		  $("#posts_menu_dropdown_clickaway_skin").show();
		} else {
			AnimateRotate("#posts_menu_icon", 180, 0, 600);
		  $("#posts_menu_dropdown").animate({top: "-310px" }, 600, function(){
				$("#posts_menu_dropdown").css("opacity", "0");
		  });
		  $("#posts_menu_dropdown").removeClass("open");
		  $("#posts_menu_dropdown").addClass("closed");
		  $("#posts_menu_dropdown_clickaway_skin").hide();
		}
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

function OpenProfileMenu(){
	AnimateRotate("#profile_menu_icon_open", 0, -180, 600);
	AnimateRotate("#profile_menu_icon_close", 0, -180, 600);
  $("#profile_menu_div").animate({right: "0px" }, 600);
  $("#profile_menu_div").addClass("open");
  $("#profile_menu_icon_open").animate({"opacity": "0" }, 600);
  $("#profile_menu_icon_close").delay(75).animate({"opacity": "1"}, 600);
  $(".profile_menu_user_name").delay(450).animate({"opacity": "1"}, 400);
  $("#profile_menu_clickaway_skin").show();
}

function CloseProfileMenu() {
	AnimateRotate("#profile_menu_icon_open", -180, 0, 500);
	AnimateRotate("#profile_menu_icon_close", -180, 0, 500);
  $("#profile_menu_div").animate({right: -$("#profile_menu_div").width() }, 600);
  $("#profile_menu_div").removeClass("open");
  $("#profile_menu_icon_open").animate({"opacity": "1" }, 600);
  $("#profile_menu_icon_close").animate({"opacity": "0"}, 500);
  $(".profile_menu_user_name").animate({"opacity": "0"}, 100);
  $("#profile_menu_clickaway_skin").hide();
}



