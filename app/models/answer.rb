class Answer < ApplicationRecord
  enum state: { pending: 0, resolved: 1, escalated: 2 }

  belongs_to :doubt
  belongs_to :user
  scope :pend_answer, -> { where("answers.state = ?", 0) }
  scope :res_answer, -> { where("answers.state = ?", 1) }
  scope :escal_answer, -> { where("answers.state = ?", 2) }

  validates_presence_of :user, :doubt, :state
  before_save :check_description
  after_commit :update_question_state

  def check_description
    self.state = 1 if self.description.present?
  end

  def update_question_state
    if self.state == 'resolved'
      st = 1
    elsif self.state == 'pending'
      st = 3
    elsif self.state == 'escalated'
      st = 2
    end
    doubt.update(state: st)
  end
end
