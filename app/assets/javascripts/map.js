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
				

				  var contentString = '<div id="content">'+
					'<div id="siteNotice">'+
					'</div>'+
					'<h1 id="firstHeading" class="firstHeading">Uluru</h1>'+
					'<div id="bodyContent">'+
					'<p><b>Uluru</b>, also referred to as <b>Ayers Rock</b>, is a large ' +
					'sandstone rock formation in the southern part of the '+
					'Northern Territory, central Australia. It lies 335&#160;km (208&#160;mi) '+
					'south west of the nearest large town, Alice Springs; 450&#160;km '+
					'(280&#160;mi) by road. Kata Tjuta and Uluru are the two major '+
					'features of the Uluru - Kata Tjuta National Park. Uluru is '+
					'sacred to the Pitjantjatjara and Yankunytjatjara, the '+
					'Aboriginal people of the area. It has many springs, waterholes, '+
					'rock caves and ancient paintings. Uluru is listed as a World '+
					'Heritage Site.</p>'+
					'<p>Attribution: Uluru, <a href="http://en.wikipedia.org/w/index.php?title=Uluru&oldid=297882194">'+
					'http://en.wikipedia.org/w/index.php?title=Uluru</a> '+
				    '(last visited June 22, 2009).</p>'+
				    '</div>'+
		      		'</div>';


				var infoWindow = new google.maps.InfoWindow({
					map: map,
					position: pos,
					content: contentString
				});


				//Add marker for current position
				var marker = new google.maps.Marker({
					position: pos,
					map: map
				});

				map.setCenter(pos);

				google.maps.event.addListener(marker, 'click', function() {
					infoWindow.open(map,marker);
				});

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






  