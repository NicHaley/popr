window.myMap = {};

myMap.init = function() {
	var options = {
		zoom: 14,
		center: new google.maps.LatLng(43.6426, -79.3871),
		mapTypeId: google.maps.MapTypeId.ROADMAP
	}

	this.canvas = new google.maps.Map($('#map-canvas')[0], options); 
};

$(document).on('ready page:load', function() {
	if ($('#map-canvas').length) {
		myMap.init();
	}
});