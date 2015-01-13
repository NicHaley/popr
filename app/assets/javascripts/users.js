// $(document).on('ready page:change', (function() {
$(document).ready(function() {
// $(document).on("page:change", function() {
  $('#search-form').submit(function(event) {
    event.preventDefault();
    var searchValue = $('#friend_search').val();

    $.getScript('/users/' + gon.user_id + '?friend_search=' + searchValue);
  });
});

$(document).ajaxSuccess(function() {
   $('#search-form').submit(function(event) {
    event.preventDefault();
    var searchValue = $('#friend_search').val();

    $.getScript('/users/' + gon.user_id + '?friend_search=' + searchValue);
  }); 

  $('#back-to-friends').click(function(event) {
    event.preventDefault();
    $.getScript('/users/' + gon.user_id);
  });  
});