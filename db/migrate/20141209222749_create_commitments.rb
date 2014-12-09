class CreateCommitments < ActiveRecord::Migration
  def change
    create_table :commitments do |t|
      t.integer :event_id
      t.integer :user_id
      t.integer :party_size

      t.timestamps
    end
  end
end
