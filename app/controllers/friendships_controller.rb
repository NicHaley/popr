class FriendshipsController < ApplicationController
	def create
		@friendship = current_user.friendships.build(friend_id: params[:friend_id])
		if Friendship.exists?(friend_id: current_user.id, user_id: params[:friend_id])
			# @friendship2 = Friendship.find(params[:friend_id])
			@friendship2 = Friendship.where(friend_id: current_user.id, user_id: params[:friend_id]).first
		end
		if @friendship.save
			if @friendship.confirmed?
				@friendship.confirm = true
				@friendship.save
				if @friendship2
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
