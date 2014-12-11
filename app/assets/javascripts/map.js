window.myMap = {};

myMap.init = function() {
	var latitude = $('#map-canvas').data('latitude');
	var longitude = $('#map-canvas').data('longitude');

	var options = {
		zoom: 14,
		center: new google.maps.LatLng(latitude, longitude),
		mapTypeId: google.maps.MapTypeId.ROADMAP
	}

	this.canvas = new google.maps.Map($('#map-canvas')[0], options); 
};

$(document).on('ready page:load', function() {
	if ($('#map-canvas').length) {
		myMap.init();
	}
});