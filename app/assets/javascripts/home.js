
$(document).ready(function(){

	// Place
  $("#intro_div").delay(11300).show(0);																					// Place intro_div after logo animation completes
  // Fade in on scroll
  $(window).scroll( function() {  																							// When the window is scrolled,
    $('.fade_in').each( function() { 																						// check the location of any element with a "fade_in" class.
      var bottom_of_object = $(this).position().top + $(this).outerHeight();		// Store position coordinates.
      var bottom_of_window = $(window).scrollTop() + $(window).height();
      if ( bottom_of_window > bottom_of_object-$(this).outerHeight()*.66 ) {	  // If the intro div is half visible in the window, fade it in.
        $(this).animate( {'opacity': '1'}, 3000 );
      } 
    });
  });

});