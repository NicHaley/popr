$(document).on('ready page:load', function() {
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
      var searchLat = results[0].geometry.location.lat();
      var searchLng = results[0].geometry.location.lng();
      var searchPos = new google.maps.LatLng(searchLat, searchLng);
      var searchMarker = new google.maps.Marker({
            position: searchPos,
            map: searchMap
      });
      $(document).ajaxSuccess(function() {  
        var image = {
          url: "assets/popcorn.png"
        };
        console.log(coords);
        coords.forEach(function(coord){

          var contentWindow = 
          '<div id="marker-wrapper"> <div id="marker-poster-container"><div id="marker-poster" style="background-image: url('+ 
          coord.poster+')"></div><div id="marker-time" class="small-caps"><b>'+ coord.time +'</b></div></div><div id="marker-details"><p><b>'+ coord.title + 
          '</b>&nbsp;(' + coord.commitment + '/' + coord.capacity + ')</p><p class="small-marker-caps">' + 
          coord.address + '</p><p class="small-marker-caps">' + coord.description + '</p></div></div>'

          var myMarker = new google.maps.Marker({
            position: new google.maps.LatLng(coord.latitude, coord.longitude),
            map: searchMap,
            animation: google.maps.Animation.DROP,
            icon: image
          });
          var infoWindow = new google.maps.InfoWindow({
            content: contentWindow
          });
          google.maps.event.addListener(myMarker, 'click', function(){
            infoWindow.open(map, myMarker)
          });
        });
});
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
