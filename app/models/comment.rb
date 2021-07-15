class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :doubt

  validates_presence_of :user, :doubt, :description
end
