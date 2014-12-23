$(document).ready(function() {

	var bgArray = ['casablanca.jpg', 'clockwork.jpg', 'lotr.jpg', 'terminator2.jpg', 'starwars.jpg', 'oz.jpg', 'godfather.jpg', 'taxi.jpg', 'alien.jpeg', '2001.jpg'];
	var bg = bgArray[Math.floor(Math.random() * bgArray.length)];
	var path = '/assets/'
	var imageUrl = path + bg;
	$('.search-window').css('background-image', 'url(' + imageUrl +')');
});