class EventsController < ApplicationController
  before_filter :set_event, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  skip_authorize_resource :only => :welcome


  def welcome
    @user = User.new
    if current_user
      redirect_to events_path
    # else
      # render :layout => false
    end
  end

  def all_events

    @events = if params[:search_location]
      Event.near(params[:search_location], 20, units: :km).select{|event|event.host.is_friend?(current_user) && event.not_passed}
    elsif params[:latitude] && params[:longitude]
      Event.near([params[:latitude], params[:longitude]], 20, units: :km).select{|event|event.host.is_friend?(current_user) && event.not_passed}
    else
      Event.all.select{|event| event.host.is_friend?(current_user) && event.not_passed} 
    end
    

    # Return current position to the map and filter by friends
    c_position = [params[:latitude], params[:longitude]]

    @current_position = Event.near(c_position, 10, units: :km)

    @friend_check = @current_position.select{|event| event.host.is_friend?(current_user) && event.not_passed}
    @nearby_coords = @friend_check.map {|event| {latitude: event.latitude.to_f, longitude: event.longitude.to_f, title: event.title}}
    respond_to do |format|
      format.html
      format.js
    end

  end

  def index
    # Finds all events hosted by user
    # Finds all events; we'll need to add logic to ensure only events 
    # of people whom are my friends are displayed 
    @events = Event.where(host_id: params[:user_id])
  end

  def show
    @commitment = current_user.commitments.find_or_initialize_by(event: @event)
    @movie = Movie.find_movie(@event.rt_id)
    @comment = @event.comments.build
  end

  def create
    @event = Event.new(event_params)
    @event.host = current_user
    # @user = User.find(params[:user_id])
    if @event.save
      redirect_to user_event_path(@event.host, @event), notice: "Event successfully created!"
    else
      render 'new', notice: "Error creating event."
    end
  end


  def edit
    @user = User.find(params[:user_id])
  end

  def update
    # @user = User.find(params[:user_id])
    # @event.update_attribute(:host_id, current_user.id)
    if @event.update(event_params) 
      redirect_to user_event_path(@event.host, @event), notice: "Event successfully modified!"
    else
      render 'edit', notice: "Error, try again!"
    end
  end

  def destroy
    @event.destroy
    redirect_to root_url, notice: "Event succesfully deleted."
  end

  private
  def event_params
    params.require(:event).permit(:time, :address, :longitude, :latitude, :description, :title, :capacity, :rt_id)
  end

  def set_event
    # This setter properly displays only the events which are hosted by user whose ID
    # is in the params. e.g. /users/1/events/12 ; Event 12 is hosted by User 1.
    # This query will not allow getting to Event 12 through User 2, i.e.
    # /users/2/events/12 .
    @event = User.find(params[:user_id]).hosted_events.where(events: {id: params[:id]}).first  
  end
end
