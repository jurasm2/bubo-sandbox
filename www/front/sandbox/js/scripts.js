// document ready
$(document).ready(function() {
	$('.slide-me').cycle({
		timeout: 3300
	});
	Shadowbox.init();

	$('a.non-clickable').click(function(e) {
		e.preventDefault();
	})

	var galleryContainer = $('.gallery-container');
	if (galleryContainer) {
		var paginatorButton = $('.paginator a');
		paginatorButton.eq(0).addClass('current');
		paginatorButton.click(function(e){
			e.preventDefault();
			var i = $(this).index();
			paginatorButton.removeClass('current');
			$(this).addClass('current');
			galleryContainer.children('div').not('.paginator, .clearfix').hide().eq(i).show();
		});
	}
});// END document ready

