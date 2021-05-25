class Lesson < ApplicationRecord
  belongs_to :course

  validates :name, :duration, presence: true
end
