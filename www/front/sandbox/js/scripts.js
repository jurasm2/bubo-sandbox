// document ready
$(document).ready(function() {
	$('.slide-me').cycle({
		timeout: 3300
	});
	Shadowbox.init();

        $('a.non-clickable').click(function(e) {
            e.preventDefault();
        })
});// END document ready