class CommitmentsController < ApplicationController
  load_and_authorize_resource
  
  def create
    @commitment = Commitment.new(commitment_params)
    # We can grab user_id and event_id because we passed them into the params
    # in the new commitment form (in the event show page).
    @event = Event.find(params[:event_id])

    @user = current_user
    @host = @event.host

    # Ensuring the instantiated commitment is attributed to the correct event 
    # and the correct user (the current_user)
    @commitment.event_id = @event.id
    @commitment.user_id = @user.id

    if @commitment.save
      redirect_to user_event_path(@host, @event), notice: "POP POP"
    else
      redirect_to user_event_path(@host, @event, commitment_errors: @commitment.errors.messages), notice: "Error joining event, try again!"
    end
  end

  def destroy
    @commitment = Commitment.find(params[:id])
    @commitment.destroy
    redirect_to events_path, notice: "Party Poopr"
  end

  def update
    @commitment = Commitment.find(params[:id])
    @event = Event.find(params[:event_id])
    @commitment.event_id = @event.id
    @commitment.user_id = current_user.id
    @host = @commitment.event.host
    if @commitment.update_attribute(:party_size, commitment_params[:party_size]) 
      redirect_to user_event_path(@host, @commitment.event), notice: "Party size successfully modified!"
    else
      redirect_to user_event_path(@host, @commitment.event), notice: "Error, try again!"
    end
  end
  private
  def commitment_params
    params.require(:commitment).permit(:party_size, :event_id, :user_id) 
  end
end
