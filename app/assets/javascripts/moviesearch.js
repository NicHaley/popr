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

        var movie_data = {
          id:               movie.id,
          posterThumb:      movie.posters["thumbnail"],
          posterOri:        movie.posters["original"].replace("tmb", "det"),
          year:             movie.year,
          critics_rating:   movie.ratings["critics_rating"],
          critics_score:    (movie.ratings["critics_score"] >= 0 ? movie.ratings["critics_score"] + "%" : "No Score"),
          icon:             (movie.ratings["critics_rating"].substr(movie.ratings["critics_rating"].length - 5) === "Fresh" ? "http://d3biamo577v4eu.cloudfront.net/static/images/trademark/fresh.png" : movie.ratings["critics_rating"] === "Rotten" ? "http://d3biamo577v4eu.cloudfront.net/static/images/trademark/rotten.png" : "http://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Icon-round-Question_mark.svg/200px-Icon-round-Question_mark.svg.png"),
          cast:             movie.abridged_cast.map(function(obj){ return obj.name }).join(", "),
          mpaa_rating:      movie.mpaa_rating,
          runtime:          movie.runtime,
          title:            movie.title

        }
        var template = $('#menu_info').html()
        var rendered = Mustache.render(template, movie_data);
        $(".search-results").append(rendered) 
      }
    });
  };

  // Need to get data from the second AJAX request (genres and directors)
  function searchCallback2(data) {
    var genres = data.genres.map(function(obj){ return obj }).join(", ");
    var directors = data.abridged_directors.map(function(obj){ return obj.name }).join(", ");

    $('.movie-genre').html('<i>' + '<strong>Genres - </strong>' + genres + '</i>');
    $('.movie-director').html('<i>' + '<strong>Directed By - </strong>' + directors + '</i>');
    $('#rating_genres').val(genres);
    $('#rating_directors').val(directors);
  }

  searchCallback = jQuery.throttle(150, searchCallback);

  // AJAX REQUEST 1
    $("#search").keyup(function(){
      query = $("#search").val();

      // send off the query
      if (query.length > 0) {
        $.ajax({
          url: moviesSearchUrl + '&q=' + encodeURI(query),
          dataType: "jsonp",
          success: searchCallback
        });
      }

      setTimeout(function(){
        if (query.length > 0) {
          $.ajax({
            url: moviesSearchUrl + '&q=' + encodeURI(query),
            dataType: "jsonp",
            success: searchCallback
          });
        }
      }, 500);
    });

  // AJAX REQUEST 2
  $(".search-results").on('click', ".movie-click", function(){
    var baseUrl2 = "http://api.rottentomatoes.com/api/public/v1.0/movies/"
    var movieId = $(this).data("id");
    var moviesSearchUrl2 = baseUrl2 + movieId + ".json?apikey=" + apikey;

    $.ajax({
      url: moviesSearchUrl2,
      dataType: "jsonp",
      success: searchCallback2
    });
  });


$(".search-results").on('click', ".movie-click", function(){
  $('#movie-poster').addClass("fade-in");
  $('#movie-poster').html('<img id="selected-poster" src="' + $(this).data("poster") + '" />' );
  
  setTimeout(function(){ 
    $('#movie-poster').removeClass("fade-in");
  }, 1500);
 
  setTimeout(function(){
      $('.form-section').fadeIn(1500);
      $("#wish-button").prop('value', 'Add It To My Wish List!');
      $("#wish-button").attr("disabled", false);
      $("#rev-button").prop('value', 'Submit Review');
      $("#rev-button").attr("disabled", false);
      $('html, body').animate({
        scrollTop: $(".form-window").offset().top - 50
      }, 2000);
    }, 1000);

  $('#event_rt_id').val($(this).data("id"));
  $('#movie_interest_rt_id').val($(this).data("id"));
  $('#rating_rt_id').val($(this).data("id"));
  $('#rating_actors').val($(this).data("cast"));
  $('.movie-title').html('<h4>' + ($(this).data("title")) + ' (' + ($(this).data("year")) + ')' + '</h4>');
  $('.movie-cast').html('<i>' + '<strong>Cast - </strong>' + $(this).data("cast") + '</i>');
  $('.movie-score').html('<img height="50" src="' + $(this).data("icon") + '" />' + '<i id="score-text"><strong> ' + $(this).data("critics_score") + '</strong></i>' );
  $('.movie-mpaa_rating').html('<i>' + '<strong>Rated - </strong>' + $(this).data("mpaa_rating") + '</i>');
  $('.movie-runtime').html('<i>' + '<strong>Runtime - </strong>' + $(this).data("runtime") + ' minutes' + '</i>');
});

  $('.form-flip').on("click", function(){
    $('.card').toggleClass("flipped");
  });


  $("body").on("click", function(){
    $(".search-results").html('');
  });

});

