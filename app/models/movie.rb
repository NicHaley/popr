class Movie
  include HTTParty
  base_uri 'api.rottentomatoes.com/api/public/v1.0'

  attr_accessor :title, :year, :poster, :synopsis, :consensus, :rating, :cast

  def initialize(options)
    @title = options['title']
    @year = options['year']
    @poster = options['posters']['original'].gsub("tmb", "det")
    @synopsis = options['synopsis']
    @consensus = options['critics_consensus']
    @rating = [options["ratings"]["critics_rating"],options["ratings"]["critics_score"]]
    @cast = options["abridged_cast"]
  end

  def self.find_movie(movie_id)
    response = JSON.parse(get("/movies/#{movie_id}.json?apikey=5z3dxvtjcr5nxmqefqnbh25z"))

    Movie.new(response)
  end
end