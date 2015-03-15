/* exported Theme */
var Theme = (function(){
	var $this;

	return {
		init: function() {
			$this = this;

			this.carousel = $('.carousel');
			this.slideshow = $('.slideshow');

			$this.setupInterface();
		},

		setupInterface: function() {

			if ($this.carousel.length) {
				$this.carouselInit();
			}

			if ($this.slideshow.length) {
				$this.slideshowInit();
			}
		},

		carouselInit: function() {
			$this.carousel.owlCarousel({
				loop: true,
				center: true,
				margin: 10,
				responsiveRefreshRate: 50,
				dots: false,
				autoWidth: true,
				items: 1,
				nav: true,
				navText: '',
				responsive: {
					768: {
						items: 2
					}
				},
				onInitialized: function() {
					$this.carousel.addClass('animated fadeIn');
				}

			});

		},

		slideshowInit: function() {
			$this.slideshow.owlCarousel({
				loop: true,
				center: true,
				responsiveRefreshRate: 50,
				dots: false,
				items: 1,
				navText: '',
				autoplay: true,
				autoplayTimeout: 2000,
				autoplayHoverPause: true,

				animateIn: 'animated fadeIn',
				animateOut: 'animated fadeOut',
				onInitialized: function() {
					$this.slideshow.addClass('animated fadeIn');
				}

			});
		}


	};
})();