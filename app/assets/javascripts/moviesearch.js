  var apikey = "asufuw64uzqn4pz7pb2v2kkt";
  var baseUrl = "http://api.rottentomatoes.com/api/public/v1.0";

// construct the uri with our apikey
var moviesSearchUrl = baseUrl + '/movies.json?apikey=' + apikey;

var query = ""

$(document).on('ready page:load', function() {

  $("#search").keyup(function(){
    query = $("#search").val();

    // send off the query
    $.ajax({
      url: moviesSearchUrl + '&q=' + encodeURI(query),
      dataType: "jsonp",
      success: searchCallback
    });
  });

  $(".search-results").on('click', ".movie-click", function(){
    $('#event_rt_id').val($(this).data("movie")).css();
  });

});

// callback for when we get back the results
function searchCallback(data) {

  $(".search-results").html('');
  var movies = data.movies;
  $.each(movies, function(index, movie) {
    if (index < 5) {
      $(".search-results").append('<div data-movie=' + movie.id + ' class="movie-click">' 
        + '<img height="50" id="img-thumb" src="' + movie.posters.thumbnail + '" />' 
        + '<div id="movie-title-cont">' + '<h5 class="movie-title">' + movie.title 
        + ' (' + movie.year + ')' + '</h5>' + '</div>' + '</div>');
      for(var i = 0; i < movie.abridged_cast.length; i++) {
        $(".search-results").append('<i>' + movie.abridged_cast[i]["name"] + ' / ' + '</i>');
      }
    }
  });
};


