class FriendshipsController < ApplicationController
	def create
		@friendship = current_user.friendships.build(friend_id: params[:friend_id])
		if @friendship.save
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
