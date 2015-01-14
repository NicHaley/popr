$(document).on('ready page:load', function() {
// $(document).ready(function() {
  $('#event-search-form').submit(function(event) {
    event.preventDefault();
    var searchValue = $('#search_location').val();

    $.getScript('/all_events/?search_location=' + searchValue);
    $('#search_location').val("");
    $("#event-search-submit")
      .val("Searching ...")
      .attr('disabled', 'disabled');
  });

  $('#near-me-button').on('click', function(event) {
    event.preventDefault();
    $('#near-me-button')
      .html("Searching ...")
      .attr('disabled', 'disabled');

    navigator.geolocation.getCurrentPosition(function(position){
      var latitude = position.coords.latitude;
      var longitude = position.coords.longitude;  
    $.getScript('/all_events?latitude=' + latitude + '&longitude=' + longitude);
    });

$('.spinner').show();
});
});

// $(document).on('ajax:beforeSend', function() {
//   alert("before");
//   $('.spinner').show();
// });

$(document).ajaxSuccess(function() {  
  $("#event-search-submit")  
    .val('Search')
    .removeAttr('disabled');

  $("#near-me-button")
    .html('Near Me')
    .removeAttr('disabled');

  $('.spinner').hide();

});