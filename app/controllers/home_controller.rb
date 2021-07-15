class HomeController < ApplicationController

  def index
    if user_signed_in?
      if current_user.ta?
        @doubt_count = Doubt.count
        users = User.includes(:escalated_answers, :solved_answers, :answers, doubts: :solved_answer).select("users.id, users.email").where(role: 'ta').group("users.id")
        @logged_ta_user = users.select{ |u| u.id == current_user.id }.first
        @non_logged_user = users.select{ |u| u.id != current_user.id }
      else
        @comment = current_user.comments.new
        @doubts = Doubt.includes(:user, :comments, :solved_answer).all.order(created_at: :desc)
      end
    end
  end
end
