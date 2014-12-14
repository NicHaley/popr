class RenameWishedAndWatched < ActiveRecord::Migration
  def change
  	rename_column :movie_interests, :watched?, :watched
  	rename_column :movie_interests, :wished?, :wished
  end
end
