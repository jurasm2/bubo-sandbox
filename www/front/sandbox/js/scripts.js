// document ready
$(document).ready(function() {
    $('.slide-me').cycle({
        timeout: 3300
    });

    $('.scroller ul').liScroll();

    var galleryContainer = $('.gallery-container');
    if (galleryContainer.length) {
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

    Shadowbox.init();
});// END document ready