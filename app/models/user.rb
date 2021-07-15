class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { student: 0, ta: 1 }

  has_many :doubts
  has_many :comments
  has_many :answers, :counter_cache => true
  has_many :solved_answers, -> { where(state: 1) }, class_name: "Answer", foreign_key: :user_id
  has_many :escalated_answers, -> { where(state: 2) }, class_name: "Answer", foreign_key: :user_id

  def avg_resolution_time
    values = []
    self.solved_answers.each do |ans|
      values << ((ans.updated_at - ans.doubt.created_at)/60).round
    end
    if values.size > 0
      "#{values.sum / values.size} Mins "
    else
      "NA"
    end
  end
end
