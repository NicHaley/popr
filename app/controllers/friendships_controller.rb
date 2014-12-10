class FriendshipsController < ApplicationController
	def create
		# Create a new friendship user_id of current_user, and friend_id of params (selected in index.html.erb)
		@friendship = current_user.friendships.build(friend_id: params[:friend_id])

		# Check if the friend has created a friendship as well. A mutual friendship is created when the first user's... 
		# ID matches the friend_id of the second user, and vice verca. Ex. Friendship if: #<Friendship id: 1, user_id: 2, friend_id: 1>
		# AND #<Friendship id: 2, user_id: 1, friend_id: 2>
		if Friendship.exists?(friend_id: current_user.id, user_id: params[:friend_id])
			@friendship2 = Friendship.where(friend_id: current_user.id, user_id: params[:friend_id]).first
		end
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
			flash[:notice] = "Added friend"
			redirect_to root_url
		else
			flash[:notice] = "unable to add friend"
			redirect_to root_url
		end
	end

	def destroy
		@friendship = Friendship.find(params[:id])
		@friendship.destroy
		flash[:notice] = "Friend deleted"
		redirect_to current_user
	end
end
