// $(document).on('ready page:load', function() {

//   function searchMap() {
  
//   if(navigator.geolocation){

//     //Set the default map settings
//     var mapOptions = {
//       zoom: 14,
//       mapTypeId: google.maps.MapTypeId.ROADMAP
//     };

//     //Set map inside the #map-canvas
//     if (document.getElementById('map-canvas')!=undefined) {
//       map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

//       //Set the current position into map
//       geocoder.geocode( { 'address': <%= params[:search_location] %> }, function(results, status) {
//       // If the status of the geocode is OK
//       if (status == google.maps.GeocoderStatus.OK) {
//       // Change the center and zoom of the map
//       var pos = results[0].geometry.location
//       map.setCenter(pos);
//       map.setZoom(10);
//       }


//         var infoWindow = new google.maps.InfoWindow({
//           map: map,
//           position: pos
//         });


//         //Add marker for current position
//         var marker = new google.maps.Marker({
//           position: pos,
//           map: map
//         });


//         google.maps.event.addListener(marker, 'click', function() {
//           infoWindow.open(map,marker);
//         });





//         $.ajax({
//           url:"/all_events",
//           method: "GET",
//           data: {
//             latitude: latitude,
//             longitude: longitude
//           },
//           dataType: 'script',
//         });

//       });
//     }
//   } else {
//       //Browser does not support geolocation
//       document.getElementById('map-canvas').innerHTML = 'No Geolocation Support.';
//   }
// };
// });