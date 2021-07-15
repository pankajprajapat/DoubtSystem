class Doubt < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_one :solved_answer, -> { where(state: 1) }, class_name: "Answer", foreign_key: :doubt_id

  validates_presence_of :user, :title, :description

  enum state: { opended: 0, fixed: 1, reopened: 2, in_progress: 3 }
end
