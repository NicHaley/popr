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
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :avatar)
  end
end
