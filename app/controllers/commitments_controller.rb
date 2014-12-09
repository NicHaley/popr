class CommitmentsController < ApplicationController
  def create
    @commitment = Commitment.new(commitment_params)
    @user = User.find(params[:user_id])
    @event = Event.find(params[:event_id])
    if @commitment.save
      redirect_to user_event_path(@user, @event), notice: "POP POP"
    else
      render 'new', notice: "Error joining event, try again!"
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
