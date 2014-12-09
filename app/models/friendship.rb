class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, :class_name => "User"

	def confirmed?
		User.find(user_id).friends.include?(User.find(friend_id)) && User.find(friend_id).friends.include?(User.find(user_id)) 
	end
end
