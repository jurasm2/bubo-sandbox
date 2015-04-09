// document ready
$(document).ready(function() {
	$('.slide-me').cycle({
		timeout: 3300
	});

	$('.scroller ul').liScroll();

	Shadowbox.init();
});// END document ready