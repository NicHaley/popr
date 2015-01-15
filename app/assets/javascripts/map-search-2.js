$(document).ajaxSuccess(function() {  
// var layer;
// var tableid =  497450;
var center = new google.maps.LatLng(10, 10);
var zoom = 2;
var searchMap;
var geocoder = new google.maps.Geocoder();

$('#event-search-form').submit(function initialize(event) {

// function initialize() {

  // Initialize the map
  searchMap = new google.maps.Map(document.getElementById('map-canvas'), {
    center: center,
    zoom: zoom,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });
  
  // Initialize the layer
  // layer = new google.maps.FusionTablesLayer({
  //   query: {
  //     select: 'lat',
  //     from: tableid
  //   },
  //   map: map
  // });


// function zoomtoaddress() {

  // Use the geocoder to geocode the address
  var address = $("#search_location").val();
  // var address = address.geocode;
  console.log(address);
  geocoder.geocode( { 'address': address }, function(results, status) {
    // If the status of the geocode is OK
    if (status == google.maps.GeocoderStatus.OK) {
      // Change the center and zoom of the map
      searchMap.setCenter(results[0].geometry.location);
      searchMap.setZoom(14);
      
      // OPTIONAL: find the new map bounds, and run a spatial query to return
      // Fusion Tables results within those bounds. 
      // sw = map.getBounds().getSouthWest();
      // ne = map.getBounds().getNorthEast();
      // layer.setOptions({
      //   query: {
      //     select: 'lat',
      //     from: tableid,
      //     where: "ST_INTERSECTS(lat, RECTANGLE(LATLNG(" + sw.lat() + "," + sw.lng() + "), LATLNG(" + ne.lat() + "," + ne.lng() + ")))"
      //   }
      // });
    } 
  });
// }
});
// Reset the zoom, center, and FusionTablesLayer query
function reset() {
  searchMap.setCenter(center);
  searchMap.setZoom(zoom);
  layer.setOptions({
    query: {
      select: 'lat',
      from: tableid
    }
  });
}

// Register Enter key press to submit form
window.onkeypress = enterSubmit;
function enterSubmit() {
  if(event.keyCode==13) {
    zoomtoaddress();
  }
}
});
