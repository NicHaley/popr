  var apikey = "asufuw64uzqn4pz7pb2v2kkt";
  var baseUrl = "http://api.rottentomatoes.com/api/public/v1.0";

// construct the uri with our apikey
var moviesSearchUrl = baseUrl + '/movies.json?apikey=' + apikey;

var query = ""

$(document).on('ready page:load', function() {

  // callback for when we get back the results
  var searchCallback = function(data) {

    $(".search-results").html('');
    var movies = data.movies;
    $.each(movies, function(index, movie) {
      if (index < 5) {
        $(".search-results").append('<div data-id=' + movie.id + ' data-poster=' + movie.posters["original"].replace("tmb", "det") + ' class="movie-click">' 
          + '<img id="img-thumb" align="left" height="50" src="' + movie.posters["thumbnail"] + '" />' 
          + (movie.ratings["critics_rating"] === "Certified Fresh" ? '<img height="13" src="http://d3biamo577v4eu.cloudfront.net/static/images/trademark/fresh.png" />' : '<img height="13" src="http://d3biamo577v4eu.cloudfront.net/static/images/trademark/rotten.png" />')
          + '<i> ' + movie.ratings["critics_score"] + '% - </i>'
          + '<div id="movie-title-cont" >' + '<h5 class="movie-title">' + movie.title 
          + ' (' + movie.year + ')' + '</h5>' + '</div>' + '</div>');
      }
    });
  };

  searchCallback = jQuery.throttle(300, searchCallback);

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
    $('#event_rt_id').val($(this).data("id"));
    $('#movie-poster').html('<img id="selected-poster" src="' + $(this).data("poster") + '" />' );
    $('#movie-details').html('<i>' +  + '</i>');
  });

  $("body").on("click", function(){
    $(".search-results").html('');
  });

});

