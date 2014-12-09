class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :time
      t.string :address
      t.decimal :longitude
      t.decimal :latitude
      t.text :description
      t.string :title
      t.integer :capacity
      t.integer :host_id

      t.timestamps
    end
  end
end
