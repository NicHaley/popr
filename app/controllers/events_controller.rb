class EventsController < ApplicationController
  before_filter :set_event, only: [:show, :edit, :update, :destroy]

  def all_events

    @events = if params[:search]
      Event.near(params[:search])
    elsif params[:latitude] && params[:longitude]
      Event.near([params[:latitude], params[:longitude]], 1, unit: :km)
    else
      Event.all 
    end

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
    @commitment = @event.commitments.build
    @commitment.user_id = current_user.id
    @movie = Movie.find_movie(@event.rt_id)
    
  end

  def new
    @event = Event.new
    @user = User.find(params[:user_id])
  end

  def create
    @event = Event.new(event_params)
    @event.host_id = current_user.id
    @user = User.find(params[:user_id])
    if @event.save
      redirect_to user_event_path(@user, @event), notice: "Event successfully created!"
    else
      render 'new', notice: "Error creating event."
    end
  end

  def edit
  end

  def update
    if @event.update_attributes(event_params) 
      redirect_to event_path(@event), notice: "Event successfully modified!"
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
    params.require(:event).permit(:time, :address, :longitude, :latitude, :description, :title, :capacity, :user_id, :rt_id)
  end

  def set_event
    # This setter properly displays only the events which are hosted by user whose ID
    # is in the params. e.g. /users/1/events/12 ; Event 12 is hosted by User 1.
    # This query will not allow getting to Event 12 through User 2, i.e.
    # /users/2/events/12 .
    @event = User.find(params[:user_id]).hosted_events.where(events: {id: params[:id]}).first  
  end
end
