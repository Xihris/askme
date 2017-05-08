class Question < ApplicationRecord
  belongs_to :user
  validates_length_of :text, maximum: 255
  validates :text, presence: true
end
