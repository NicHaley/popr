class RatingsController < ApplicationController
	before_filter :load_user
	load_and_authorize_resource

	def index
		@user = User.find(params[:user_id])
		@ratings = @user.ratings.order(created_at: :desc).page(params[:page])
	end

	def show
		@rating = Rating.find(params[:id])
	end

	def create
		@rating = @user.ratings.build(rating_params)

		respond_to do |format|
			if @rating.save
				format.html {redirect_to user_path(current_user), notice: "Rating successfully created"}
				format.js {}
			else
				format.html {render 'movie_interests/new'}
				format.js {}
				flash.now[:alert] = "Ensure review is filled and star rating is selected."
			end
		end

	end

	def edit
		@rating = Rating.find(params[:id])
	end

	def update
		@rating = Rating.find(params[:id])
		@rating.review = params[:rating][:review]
		@rating.user_score = params[:rating][:user_score]
		if @rating.save
			redirect_to user_path(@user), notice: "Rating successfully updated"
		else
			render 'movie_interests/edit'
			flash.now[:alert] = "Ensure review is filled and star rating is selected."
		end
	end

	def destroy
		@rating = Rating.find(params[:id])
		@rating.destroy
		redirect_to user_path(current_user)
	end

	private
	def rating_params
		params.require(:rating).permit(:user_id, :user_score, :watched, :review, :rt_id, :actors, :directors, :genres)
	end

	def load_user
		@user = User.find(params[:user_id])
	end
end
