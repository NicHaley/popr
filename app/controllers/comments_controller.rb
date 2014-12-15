class CommentsController < ApplicationController
  before_filter :load_event
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.event_id = @event.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to user_event_path(@event.host, @event), notice: 'Comment added successfully' }
        format.js {}
      else
        format.html { redirect_to user_event_path(@event.host, @event), notice: 'Failed, try again!' }
        format.js {}
      end
    end
  end

  def update

  end

  def destroy
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to user_event_path(@event.host, @event), notice: 'Comment deleted' }
        format.js {}
      else
        format.html { redirect_to user_event_path(@event.host, @event), notice: 'Failed, try again!' }
        format.js {}
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :event_id, :user_id)
  end

  def load_event
    @event = Event.find(params[:event_id])
  end
end
