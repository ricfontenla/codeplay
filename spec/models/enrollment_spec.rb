require 'rails_helper'

describe Enrollment do
  context 'User has a course' do
    it 'and cannot buy it again' do
      user = User.create!(email: 'jane_doe@codeplay.com', 
                          password: '123456')
      instructor = Instructor.create!(name: 'Fulano Fulano', 
                            email: 'fulano@codeplay.com.br', 
                            bio: 'Dev e instrutor na Code Play')
      course = Course.create!(name: 'Ruby', 
                              description: 'Um curso de Ruby',
                              code: 'RUBYBASIC', 
                              price: 10,
                              enrollment_deadline: '22/12/2033',
                              instructor: instructor)
      Enrollment.create!(user_id: user.id, 
                         course_id: course.id)
      should validate_uniqueness_of(:course_id).scoped_to(:user_id).with_message('já está em uso')
    end
  end
end