class MovieInterestsController < ApplicationController
  before_filter :set_movie_interest, only: [:show, :edit, :update, :destroy]

  def index
    @movie_interests = MovieInterest.where(user_id: current_user.id)
  end
  
  def show
  end

  def new
    @movie_interest = MovieInterest.new
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
    @movie_interest = @user.movie_interests.build(movie_interest_params)

    if @movie_interest.save
      redirect_to root_url, notice: "Movie interest created!"
    else
      render 'new', notice: 'Error creating movie interest'
    end
  end

  def edit
  end

  def update
    if @movie_interest.update_attributes(movie_interest_params)
      redirect_to user_movie_interests_path(@user), notice: "Movie interest updated!"
    else
      render 'edit', notice: "Error, try again!"
    end
  end
  
  def destroy
    @movie_interest.destroy
     redirect_to user_movie_interests_path(@user), notice: "Movie interest succesfully deleted."
  end

  private
  def movie_interest_params
    params.require(:movie_interest).permit(:rt_id, :event_id, :user_id, :watched, :wished, :user_score)
  end

   def set_movie_interest
    @movie_interest = MovieInterest.find(params[:id])
  end
end
