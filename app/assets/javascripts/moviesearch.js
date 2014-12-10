  var apikey = "asufuw64uzqn4pz7pb2v2kkt";
  var baseUrl = "http://api.rottentomatoes.com/api/public/v1.0";

// construct the uri with our apikey
var moviesSearchUrl = baseUrl + '/movies.json?apikey=' + apikey;

var query = ""

$(function() {

  $("#search").keyup(function(){
    query = $("#search").val();

    // send off the query
    $.ajax({
      url: moviesSearchUrl + '&q=' + encodeURI(query),
      dataType: "jsonp",
      success: searchCallback
    });
  });

  $(".search_results").on('click', ".movie-click", function(){
    console.log(this);
  });

});

// callback for when we get back the results
function searchCallback(data) {

  $(".search_results").html('');
  var movies = data.movies;
  $.each(movies, function(index, movie) {
    if (index < 5) {
    $(".search_results").append('<div data=' + movie.id + ' class="movie-click">' + '<h1>' + movie.title + '</h1>' + '<img src="' + movie.posters.thumbnail + '" />' + '</div>');
   }
  });
};


