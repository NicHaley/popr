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
          icon:             (movie.ratings["critics_rating"] === "Certified Fresh" ? "http://d3biamo577v4eu.cloudfront.net/static/images/trademark/fresh.png" : movie.ratings["critics_rating"] === "Rotten" ? "http://d3biamo577v4eu.cloudfront.net/static/images/trademark/rotten.png" : ""),
          cast:             movie.abridged_cast.map(function(obj){ return obj.name }).join(", "),
          title:            movie.title

        }
        var template = $('#menu_info').html()
        var rendered = Mustache.render(template, movie_data);
        $(".search-results").append(rendered) 

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
    if ($("body").data("controller") == "events") {
      $('#event_rt_id').val($(this).data("id"));
      $('#movie-poster').html('<img id="selected-poster" src="' + $(this).data("poster") + '" />' );
    }
    else if ($("body").data("controller") == "movie_interests"){
      $('#movie_interest_rt_id').val($(this).data("id"));
      $('#movie-poster').html('<img id="selected-poster" src="' + $(this).data("poster") + '" />' );
      $('#movie-title').html('<h5>' + ($(this).data("title")) + ' (' + ($(this).data("year")) + ')' + '</h5>');
      // for (var i = 0; i < $(this).data("cast").length; i++) {
      //   $('#movie-cast').html('<h5>' + ($(this).data("cast")["name"][i]) + '</h5>');
      // }
    }
  });

  $("body").on("click", function(){
    $(".search-results").html('');
  });

});

