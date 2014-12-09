class EventsController < ApplicationController
  before_filter :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to event_path(@event), notice: "Event successfully created!"
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
    params.require(:event).permit(:time, :address, :longitude, :latitude, :description, :title, :capacity)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
