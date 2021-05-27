class Lesson < ApplicationRecord
  belongs_to :course

  validates :name, :duration, presence: true
  validates :duration, numericality: { only_integer: true, greater_than: 0 }
end
