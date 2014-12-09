class CreateMovieInterests < ActiveRecord::Migration
  def change
    create_table :movie_interests do |t|
      t.integer :rt_id
      t.integer :event_id
      t.integer :user_id
      t.boolean :watched?
      t.boolean :wished?
      t.integer :user_score

      t.timestamps
    end
  end
end
