// document ready
$(document).ready(function() {
    $('#slideshow').after('<div id="slider-nav">').cycle({
        timeout: 4000,
        pause: true,
        pager:  '#slider-nav'
    });
    Shadowbox.init();


    var $container = $('.references-container');
    $container.masonry({
        isAnimated: true,

        transitionDuration: '0.5s',
        itemSelector: '.reference-box'
    });

    var popupOverlay = $('.popup-overlay');
    if (popupOverlay.length) {
        var popupOpener = $('.open-popup');
        var popupCloser = $('.close-popup');
        var popupContainer = popupOverlay.find('.popup-container')
        popupOpener.click(function(e){
            e.preventDefault();
                $.get(this.href, function (payload) {
                    popupContainer.find('h3').text(payload.title);
                    popupContainer.find('.popup-content').html(payload.html);
                    // refresh nette validation
                    var form = popupContainer.find('form');
                    Nette.initForm(form[0]);
                    showHidePopup('show');

                    // hiding of IC
                    $('#frmbuyForm-is_company').click('click', function() {
                        var _this = $(this);
                        if (_this.is(':checked')) {
                            $('._hidable_ic').slideDown();
                        } else {
                            $('._hidable_ic').slideUp();
                        }
                    });

                    // at least one checkbox validation
                    $('#frmbuyForm-send').click(function() {
                        if ($('input:checkbox:checked', popupContainer.find('form')).size() == 0) {
                            alert('Select one course at least!');
                            return false;
                        }
                    })

                });
        });
        popupCloser.add(popupOverlay).click(function(e){
            e.preventDefault();
            showHidePopup('hide');
        });
        popupContainer.click(function(e){
            e.stopPropagation();
        });
    }

});
// END document ready
function showHidePopup(action) {

    var popupOverlay = $('.popup-overlay');
    var popupContainer = popupOverlay.find('.popup-container')

    if (action == 'show') {
        popupOverlay.stop().fadeIn(150);
        popupContainer.addClass('bounceIn');
        var popupHeight = popupContainer.outerHeight();
        var windowHeight = $(window).height();
        var topPos = '50%';
        var marginTop = -popupHeight/2;

        if (popupHeight > windowHeight) {
            topPos = 20;
            marginTop = 0;
        }

        popupContainer.css({
            'margin-top': marginTop,
            top: topPos
        });
    } else if (action == 'hide') {
        popupOverlay.stop().fadeOut(150);
    }
    var requiredInput = $('.input-container.required');
    if (requiredInput.length) {
        requiredInput.each(function(){
            var $this = $(this);
            $('<span/>', {
                'class':'asterisk'
            }).appendTo($this);
        });
    }
}
