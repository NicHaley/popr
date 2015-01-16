class UsersController < ApplicationController
  skip_load_and_authorize_resource :only => [:new, :create, :activate]
  skip_before_filter :require_login, :only => [:new, :create, :activate]
  load_and_authorize_resource

  def activate
    if (@user = User.load_from_activation_token(params[:id]))
      @user.activate!
      redirect_to(root_path, :notice => 'User was successfully activated.')
    else
      not_authenticated
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.first_name.capitalize!
    @user.last_name.capitalize!
    if @user.save

      redirect_to root_path, notice: "Success! Please check confirmation email"
    else
      flash.now[:alert] = "An error occurred!"
      render 'events/welcome'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.hosted_events.each do |event|
      event.commitments.destroy_all
      event.comment.destroy_all
    end
    @user.hosted_events.destroy_all
    @user.commitments.destroy_all
    @user.comments.destroy_all
    @user.movie_interests.destroy_all
    @user.ratings.destroy_all
    @user.friendships.destroy_all
    Friendship.where(friend_id: @user.id).destroy_all
    @user.destroy
    redirect_to root_path, notice: "User deleted :("
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to user_path(@user), notice: "Changes successful"
    else
      flash.now[:alert] = "An error occurred!"
      render 'edit'
    end
  end

  def index
    if current_user
      @users = if params[:user_search]
        User.where("LOWER(first_name) LIKE LOWER(?) OR LOWER(last_name) LIKE LOWER(?)", "%#{params[:user_search]}%", "%#{params[:user_search]}%").select{|u| !u.is_friend?(current_user)}.sort{|x,y| x.first_name <=> y.first_name}
      else
        User.select{|u| !u.is_friend?(current_user) && u.id != current_user.id}.sort{|x,y| x.first_name <=> y.first_name}
      end
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @user = User.find(params[:id])
    @attending = @user.commitments.order(created_at: :desc).page(params[:attending_page]).per(4)
    @ratings = @user.ratings.order(created_at: :desc).page(params[:ratings_page]).per(3)


    if current_user
      if params[:friend_search]
        @friends = User.where("LOWER(first_name) LIKE LOWER(?) OR LOWER(last_name) LIKE LOWER(?)", "%#{params[:friend_search]}%", "%#{params[:friend_search]}%").select{|u| u.is_friend?(@user)}.sort{|x,y| x.first_name <=> y.first_name}
        @friends = Kaminari.paginate_array(@friends).page(params[:friends_page]).per(6)
      else
        @friends = @user.friendships.sort{|x,y| x.friend.first_name <=> y.friend.first_name}
        @friends = Kaminari.paginate_array(@friends).page(params[:friends_page]).per(6)
      end
    end

    @user_id = @user.id
    gon.user_id = @user.id

    if @user.ratings.any?
      print totalScore = (@user.ratings.all.inject(0){|sum, rating| sum + rating.user_score}).to_f
      print maxScore = ((@user.ratings.all.count) * 5).to_f
      print averageScore = ((totalScore / maxScore).to_f * 100.0).round(1)
      print gon.average = ["Average Movie Rating", averageScore]

      # Favourite Genres
      def pieData(dataList)
        dataHash = dataList.each_with_object(Hash.new(0)) { |word,counts| counts[word] += 1 }
        dataArray = dataHash.map{|key, value| [key, value]}
        sortedArray = dataArray.sort!{|x,y| y[1] <=> x[1]}
        if sortedArray.length < 5
          return sortedArray[0..sortedArray.length]
        else
          return sortedArray[0..4] << ["Other", sortedArray[5..-1].inject(0){|sum, x| sum + x[1]}]
        end
      end

      genreList = @user.ratings.all.map{|rating| [] << rating.genres.split(", ").flatten}.flatten
      gon.genres = pieData(genreList);

      actorsList = @user.ratings.all.map{|rating| [] << rating.actors.split(", ").flatten}.flatten
      gon.actors = pieData(actorsList);

      directorsList = @user.ratings.all.map{|rating| [] << rating.directors.split(", ").flatten}.flatten
      gon.directors = pieData(directorsList);
    end

    respond_to do |format|
      format.html
      format.js
    end

  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :avatar, :bio, :hometown)
  end
end
