window.myMap = {};


$(document).on('ready page:load', function() {
	if ($('#map-canvas').length) {
		myMap.init();
	}
});

myMap.init = function() {
	if(navigator.geolocation){

	var map;
	
	var mapOptions = {
		zoom: 14,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	

	map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

	navigator.geolocation.getCurrentPosition(function(position){

		var pos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
		var infoWindow = new google.maps.InfoWindow({
			map: map,
			position: pos,
			content: 'You are here.'
		});

		map.setCenter(pos);

	});

	} else {
	  	//Browser does not support geolocation
	  	document.getElementById('map-canvas').innerHTML = 'No Geolocation Support.';
	}

};


// myMap.init = function() {
// 	var latitude = $('#map-canvas').data('latitude');
// 	var longitude = $('#map-canvas').data('longitude');

// 	var options = {
// 		zoom: 14,
// 		center: new google.maps.LatLng(latitude, longitude),
// 		mapTypeId: google.maps.MapTypeId.ROADMAP
// 	}

// 	this.canvas = new google.maps.Map($('#map-canvas')[0], options); 



// }

// 	if(showMarker) {
// 		this.addMarker(latitude, longitude);
// 	}

// 	if(coords){
// 		coords.forEach(function(coord){
// 			myMap.addMarker(coord.latitude, coord.longitude, "http://maps.google.com/mapfiles/ms/icons/yellow-dot.png");
// 		});
// 	}
// };


// myMap.addMarkers = function(latitude, longitude, image){
// 	var marker = new google.maps.Marker({
// 		position: new goodle.maps.LatLng(latitude, longitude),
// 		map: this.canvas,
// 		icon: image
// 	});
// }





  