class FriendshipsController < ApplicationController
	load_and_authorize_resource
	def create
		# Create a new friendship user_id of current_user, and friend_id of params (selected in index.html.erb)
		@friendship = current_user.friendships.build(friend_id: params[:friend_id])
		@users = User.select{|u| !u.is_friend?(current_user) && u.id != current_user.id}.sort
		# Check if the friend has created a friendship as well. A mutual friendship is created when the first user's... 
		# ID matches the friend_id of the second user, and vice verca. Ex. Friendship if: #<Friendship id: 1, user_id: 2, friend_id: 1>
		# AND #<Friendship id: 2, user_id: 1, friend_id: 2>
		if Friendship.exists?(friend_id: current_user.id, user_id: params[:friend_id])
			@friendship2 = Friendship.where(friend_id: current_user.id, user_id: params[:friend_id]).first
		end

		respond_to do |format|

			if @friendship.save

				# Confirm using defined friendship method if both users have befriended each other
				if @friendship.confirmed?
					@friendship.confirm = true
					@friendship.save
					if @friendship2			#I don't think we need this nested if statement
						@friendship2.confirm = true
						@friendship2.save
					end
				end
				format.html {redirect_to user_path(current_user)}
				format.js {}
			else
				format.html {redirect_to root_url}
				format.js {}
			end
		end
	end

	def destroy
		@friendship = Friendship.find(params[:id])
		@friendship.destroy
		@friendship2 = Friendship.where(friend_id: current_user.id, user_id: params[:friend_id]).first
		if @friendship2	
			@friendship2.destroy
		end	
		flash[:notice] = "Friend removed"
		redirect_to current_user
	end
end
