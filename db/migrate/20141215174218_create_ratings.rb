class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_score
      t.string :review
      t.integer :rt_id
      t.integer :event_id
      t.integer :user_id

      t.timestamps
    end
  end
end
