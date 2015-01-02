window.myMap = {};

var map;

$(document).on('ready page:load', function() {

	if ("geolocation" in navigator) {
		//Initialize the map on page load
		myMap.init();
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
				

				  var contentString = 
					'<p><b>Welcome!</b> Popr is a way to connect you with all your friends to enjoy all your favorite movies '+
					'together with your friends! '+
					'south west of the nearest large town, Alice Springs; 450&#160;km '+
					'(280&#160;mi) by road.'+
					'rock caves and ancient paintings. Uluru is listed as a World '+
					'Heritage Site.</p>'+
					'<p>Attribution: Uluru, <a href="http://en.wikipedia.org/w/index.php?title=Uluru&oldid=297882194">'+
					'http://en.wikipedia.org/w/index.php?title=Uluru</a> '+
				    '(last visited June 22, 2009).</p>';


				var infoWindow = new google.maps.InfoWindow({
					map: map,
					position: pos
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

	var image = {
		url: "assets/popcorn.png"
	};

	coords.forEach(function(coord){
		var myMarker = new google.maps.Marker({
			position: new google.maps.LatLng(coord.latitude, coord.longitude),
			map: map,
			animation: google.maps.Animation.DROP,
			icon: image
		});
		var infoWindow = new google.maps.InfoWindow({
			content: coord.title
		});
		google.maps.event.addListener(myMarker, 'click', function(){
			infoWindow.open(map, myMarker)
		});
	});
}





  