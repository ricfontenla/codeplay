class Course < ApplicationRecord
  belongs_to :instructor
  has_many :lessons, dependent: :destroy

  validates :name, :code, :price, :enrollment_deadline, presence: true
  validates :code, uniqueness: true

  has_many :enrollments
  has_many :users, through: :enrollments

  scope :available, -> { where(enrollment_deadline: Date.current..) }
end
