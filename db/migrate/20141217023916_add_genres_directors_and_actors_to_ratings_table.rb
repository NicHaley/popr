class AddGenresDirectorsAndActorsToRatingsTable < ActiveRecord::Migration
  def change
  	add_column :ratings, :actors, :string
  	add_column :ratings, :directors, :string
  	add_column :ratings, :genres, :string
  end
end
