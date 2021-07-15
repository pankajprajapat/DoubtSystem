class DoubtsController < ApplicationController

  def index
    if current_user.ta?
      @answer = current_user.answers.pend_answer.first
      if @answer.present?
        redirect_to new_doubt_answer_path(@answer.doubt)
      else
        @doubts = Doubt.where(state: [0,2])
      end
    else
      redirect_to root_path, alert: "You don't have access for this section."
    end
  end

  def new
    @doubt = current_user.doubts.new
  end

  def create
    @doubt = current_user.doubts.new(doubt_params)
    respond_to do |format|
      if @doubt.save
        format.html { redirect_to root_path, notice: 'Doubt has been submitted.' }
      else
        format.html { render :new, alert: @doubt.errors.full_messages }
      end
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end

  private

  def doubt_params
    params.require(:doubt).permit(
      :title, :description
    )
  end

end
