class Course < ApplicationRecord
  belongs_to :instructor
  has_many :lessons

  validates :name, :code, :price, presence: true
  validates :code, uniqueness: true
end
