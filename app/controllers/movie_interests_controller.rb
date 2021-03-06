class MovieInterestsController < ApplicationController
  before_filter :set_movie_interest, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource


  def new
    @movie_interest = MovieInterest.new
    @user = User.find(params[:user_id])
    @rating = @user.ratings.build
    @event = Event.new
  end

  def create
    @user = User.find(params[:user_id])
    @movie_interest = @user.movie_interests.build(movie_interest_params)

    respond_to do |format|
      if @movie_interest.save
        format.html {redirect_to root_url, notice: "Movie interest created!"}
        format.js{}
      else
        format.html {render 'new', notice: 'Error creating movie interest'}
        format.js{}
      end
    end
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
    flash[:notice] = "Wished item deleted"
    redirect_to current_user
  end

  private
  def movie_interest_params
    params.require(:movie_interest).permit(:rt_id, :event_id, :user_id, :watched, :wished, :user_score)
  end

  def set_movie_interest
    @movie_interest = MovieInterest.find(params[:id])
  end
end
