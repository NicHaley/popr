class CommitmentsController < ApplicationController
  def create
    @commitment = Commitment.new(commitment_params)
    # We can grab user_id and event_id because we passed them into the params
    # in the new commitment form (in the event show page).
    @event = Event.find(params[:event_id])
    @host = @event.host
    @user = current_user
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
    redirect_to root_path, notice: "party poopr"
  end

  def update
    @commitment = Commitment.find(params[:id])
    if @commitment.update_attributes(commitment_params) 
      redirect_to commitment_path(@commitment), notice: "Event successfully modified!"
    else
      render 'edit', notice: "Error, try again!"
    end
  end
  private
  def commitment_params
    params.require(:commitment).permit(:party_size, :event_id, :user_id) 
  end
end
