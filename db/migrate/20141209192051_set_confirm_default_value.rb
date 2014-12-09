class SetConfirmDefaultValue < ActiveRecord::Migration
  def change
  	change_column_default :friendships, :confirm, false
  end
end
