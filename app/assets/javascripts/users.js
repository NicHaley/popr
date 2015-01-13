$(document).ready(function() {
  $('#search-form').submit(function(event) {
    event.preventDefault();
    var searchValue = $('#friend_search').val();

    $.getScript('/users/' + gon.user_id + '?friend_search=' + searchValue);
  });
});