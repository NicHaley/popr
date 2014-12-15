window.myMap = {};

var map;

$(document).on('ready page:load', function() {

	if ("geolocation" in navigator) {
		//Initialize the map on page load
		myMap.init();

		// Retrieve the coords of all events
		var coords = $('#map-canvas').data('coords');

		if (coords){
			myMap.addMarkers(coords);
		}

	}
});

//Initialize Map
myMap.init = function() {
	
	if(navigator.geolocation){

		//Set the default map settings
		var mapOptions = {
			zoom: 14,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		};

		//Set map inside the #map-canvas
		if (document.getElementById('map-canvas')!=undefined) {
			map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

			//Set the current position into map
			navigator.geolocation.getCurrentPosition(function(position){

				var pos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
				var infoWindow = new google.maps.InfoWindow({
					map: map,
					position: pos
				});
				//Add marker for current position
				var marker = new google.maps.Marker({
					position: new google.maps.LatLng(position.coords.latitude, position.coords.longitude),
					map: map
				});

				map.setCenter(pos);

				var latitude = position.coords.latitude;
				var longitude = position.coords.longitude;	

				console.log("Lat:", latitude, "Long:", longitude);

				$.ajax({
					url:"/all_events",
					method: "GET",
					data: {
						latitude: latitude,
						longitude: longitude
					},
					dataType: 'script',
				});

			});
		}
	} else {
	  	//Browser does not support geolocation
	  	document.getElementById('map-canvas').innerHTML = 'No Geolocation Support.';
	}
};


//Add markers for other events
myMap.addMarkers = function(coords){

	var image = "http://maps.google.com/mapfiles/ms/icons/yellow-dot.png"

	coords.forEach(function(coord){
		var myMarker = new google.maps.Marker({
			position: new google.maps.LatLng(coord.latitude, coord.longitude),
			map: map,
			icon: image
		});
	});
}






  