$(document).ready(function() {
	$('ul#quotes').quote_rotator();
	// infinitescroll() is called on the element that surrounds
	// the items you will be loading more of
	if ($('#twitter-area .container_24').length) {
		$('#twitter-area .container_24').infinitescroll({
			navSelector: "#next",
			nextSelector: "#next a:first",
			itemSelector: "div.bubbles",
			loadingText: "Loading more reviews...",
			loadingImg: "/images/used/ajax-loading.gif",
			donetext: "We've hit the end of the reviews."
		});
	}

	if ($('#movies-page .container_24').length) {
		$('#movies-page .container_24').infinitescroll({
			navSelector: "#next",
			nextSelector: "#next a:first",
			itemSelector: ".movies-list",
			loadingText: "Loading more movies...",
			loadingImg: "/images/used/ajax-loading.gif",
			donetext: "We've hit the end of the reviews."
		});
	}
	window.fbAsyncInit = function() {
		FB.init({
			appId: "162180660488445",
			status: true,
			// check login status
			cookie: true,
			// enable cookies to allow the server to access the session
			xfbml: true // parse XFBML
		});
	};
});

