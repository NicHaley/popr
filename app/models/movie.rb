class Movie
  include HTTParty
  base_uri 'api.rottentomatoes.com/api/public/v1.0'
  attr_accessor :title, :year, :poster, :synopsis, :consensus, :rating, :cast

  def initialize(options)
    # The initialize() method stores insatnce variables of the returned JSON object 
    # values. We only assign values we want to retrieve/ display. This allows us to 
    # call @instance.[attribute] methods on our movies. 
    puts options
    puts Time.now
    @title = options['title']
    @year = options['year']
    @poster = options['posters']['original'].gsub("tmb", "det")
    @synopsis = options['synopsis']
    @consensus = options['critics_consensus']
    @rating = [options["ratings"]["critics_rating"],options["ratings"]["critics_score"]]
    @cast = options["abridged_cast"]
  end

  def self.find_movie(movie_id)
    api_key = ["5z3dxvtjcr5nxmqefqnbh25z", "asufuw64uzqn4pz7pb2v2kkt"]
    $key ||= 0
    rotten_api = ""
    if $key == 0
      rotten_api = api_key[0]
      $key = 1
    else
      rotten_api = api_key[1]
      $key = 0
    end

    # The .find_movie function is called on the Movie class in the EventsController
    # show action, and is passed that specific event's rt_id. We pass the response 
    # into JSON.parse() as the Rotten Tomatoes API returns a string.
    response = JSON.parse(get("/movies/#{movie_id}.json?apikey=" + rotten_api.to_s))
    # We then instantiate an instance of the Movie class passing it the response.
    # This calls the initialize() method.
    Movie.new(response)
  end
end
