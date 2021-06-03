class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :course_id, uniqueness: { scope: :user_id }
end
