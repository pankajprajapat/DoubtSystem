class CommentsController < ApplicationController

  def create
    respond_to do |format|
      format.js do
        @doubt = Doubt.find(params[:doubt_id])
        @doubt.comments.create(comment_params)
        @comments = @doubt.comments
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(
      :description
    ).merge(user_id: current_user.id)
  end
end
