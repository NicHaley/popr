$(document).ready(function() {
  $('#search-form').submit(function(event) {
    event.preventDefault();
    var searchValue = $('#user_search').val();

    $.getScript('/users/?user_search=' + searchValue);
    $('#back-to-users').show();
  });
});
