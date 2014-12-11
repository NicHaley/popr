class AddRtidToEvent < ActiveRecord::Migration
  def change
  	add_column :events, :rt_id, :integer
  end
end
