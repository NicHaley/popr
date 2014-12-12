function geolocationSuccess(position){
	var latitude = position.coords.latitude;
	var longitude = position.coords.longitude;

	$('#map-canvas').data('latitude', latitude);
	$('#map-canvas').data('longitude', longitude);

	$('.location-error').hide();

	$.ajax({
		url:"/all_events",
		method: "GET",
		data: {
			latitude: latitude,
			longitude: longitude
		},
		dataType: 'script'
	});

}

function geolocationError(){
	var $locationError = $('<p> Unable to find your location </p>')
	$locationError.addClass('location-error');
	$("#current-location").after($locationError)
}

$(document).ready(function() {
	
	if("geolocation" in navigator) {
		navigator.geolocation.getCurrentPosition(geolocationSuccess, geolocationError);
	} else {
		alert("Error!");
	}

});







// $(document).on('ready page:load', function(){
// 	$('#current-location').on('click', function(){
// 		if("geolocation" in navigator) {
// 			navigator.geolocation.getCurrentPosition(geolocationSuccess, geolocationError);
// 		} else {
// 			alert("Error!");
// 		}
// 	});
// });


