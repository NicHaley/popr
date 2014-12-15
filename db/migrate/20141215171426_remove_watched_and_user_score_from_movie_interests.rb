class RemoveWatchedAndUserScoreFromMovieInterests < ActiveRecord::Migration
  def change
  	remove_column :movie_interests, :watched
  	remove_column :movie_interests, :user_score
  end
end
