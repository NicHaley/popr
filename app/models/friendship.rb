class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, :class_name => "User"

	# Returns true if the user has the friend_id, and the friend has the user_id
	def confirmed?
		User.find(user_id).friends.include?(User.find(friend_id)) && User.find(friend_id).friends.include?(User.find(user_id)) 
	end

  def friend_full_name
    self.friend.first_name + " " + self.friend.last_name
  end
end
