class Course < ApplicationRecord
  belongs_to :instructor
  has_many :lessons, dependent: :destroy

  validates :name, :code, :price, presence: true
  validates :code, uniqueness: true
end
