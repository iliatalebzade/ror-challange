class Question < ApplicationRecord
  belongs_to :user

  # making sure that the title is provided
  validates :title, presence: true
end
