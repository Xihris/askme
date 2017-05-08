class Question < ApplicationRecord
  belongs_to :user
  validates :text, length: {maximum: 255}
  validates :text, presence: true
end
