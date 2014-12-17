class UsersController < ApplicationController
  before_filter :require_login, only: [:show, :destroy, :edit]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: "Success! Welcome to Popr!"
    else
      render 'new', notice: "Errors signing up, try again!"
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to root_path, notice: "User deleted :("
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      redirect_to user_path(@user), notice: "Changes successful."
    else
      render 'edit', notice: "Error, try again!"
    end
  end

  def index
    if params[:user_search]
      @users = User.search(params[:user_search]).order("created_at DESC")
    else
      @users = User.all.order('created_at DESC')
  end
  end

  def show
    @user = User.find(params[:id])
    @ratings = @user.ratings.order(created_at: :desc).limit(5)
    @events = Event.all.select{|event|event.host.id == @user.id}
    @userCommitments = @user.commitments.all

    # Favourite Genres
    def pieData(dataList)
      dataHash = dataList.each_with_object(Hash.new(0)) { |word,counts| counts[word] += 1 }
      dataArray = dataHash.map{|key, value| [key, value]}
      sortedArray = dataArray.sort!{|x,y| y[1] <=> x[1]}
      return sortedArray[0..4] << ["Other", sortedArray[5..-1].inject(0){|sum, x| sum + x[1]}]
    end

    genreList = @user.ratings.all.map{|rating| [] << rating.genres.split(", ").flatten}.flatten
    gon.genres = pieData(genreList);

    actorsList = @user.ratings.all.map{|rating| [] << rating.actors.split(", ").flatten}.flatten
    gon.actors = pieData(actorsList);

    directorsList = @user.ratings.all.map{|rating| [] << rating.directors.split(", ").flatten}.flatten
    gon.directors = pieData(directorsList);

  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :avatar)
  end
end
