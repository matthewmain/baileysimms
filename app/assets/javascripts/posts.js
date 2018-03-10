
$(document).ready(function(){

	// PARALLAX SCROLLING
	var $element = $("#banner")												// selects the element to be scrolled
	var top = parseInt($element.css("top"))  					// records the starting 'top' attribute value of the element
	var speed = .8																		// sets the scroll speed: 1 is normal, >1 is faster, <1 is slower, 0 is none, and <0 is reverse
	$(window).scroll(function(){
	  var scroll = $(window).scrollTop();
	  $element.css("top",(top-scroll*speed)+"px");
	});

});