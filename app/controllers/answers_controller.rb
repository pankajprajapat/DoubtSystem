class AnswersController < ApplicationController

  def new
    @doubt = Doubt.find(params[:doubt_id])
    @answer = Answer.find_or_initialize_by(doubt_id: params[:doubt_id], user_id: current_user.id)
    @answer.state = 0
    @answer.save
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.attributes = answer_params
    if @answer.save
      redirect_to root_path
    else
      redirect_to new_doubt_answer_path(@answer.doubt, @answer)
    end
  end

  private

  def answer_params
    params.require(:answer).permit(
      :description, :state
    )
  end
end
