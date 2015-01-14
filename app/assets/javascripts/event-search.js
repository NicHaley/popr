$(document).ready(function() {
  $('#event-search-form').submit(function(event) {
    event.preventDefault();
    var searchValue = $('#search_location').val();

    $.getScript('/all_events/?search_location=' + searchValue);
  });

});
