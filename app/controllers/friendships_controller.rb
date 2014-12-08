class FriendshipsController < ApplicationController
	def create
		@friendship = current_user.friendships.build(friends_id: params[:friend_id])
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
		redirect_to root_url
	end
end
