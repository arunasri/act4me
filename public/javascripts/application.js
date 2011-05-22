$(document).ready(function() {
	$('ul#quotes').quote_rotator();
	// infinitescroll() is called on the element that surrounds
	// the items you will be loading more of
	$('#twitter-area .container_24').infinitescroll({
		navSelector: "#next",
		nextSelector: "#next a:first",
		itemSelector: "div.bubbles",
		loadingText: "Loading more reviews...",
		loadingImg: "/images/used/ajax-loading.gif",
		donetext: "We've hit the end of the reviews."
	});
	FB.init({
		appId: '162180660488445',
		status: true,
		cookie: true,
		xfbml: true
	});
});

