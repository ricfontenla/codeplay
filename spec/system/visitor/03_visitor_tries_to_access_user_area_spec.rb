require 'rails_helper'

describe 'Visitor tries to access user area' do
  context 'of courses' do
    it 'and cannot view course details' do
      visit user_course_path(1)

      expect(current_path).to eq(new_user_session_path)
    end

    it 'and cannot se user enrollments' do
      visit my_enrollments_user_courses_path

      expect(current_path).to eq(new_user_session_path)
    end
  end

  context 'of lessons' do
    it 'and cannot view lessons' do
      visit user_course_lesson_path(1, 1)

      expect(current_path).to eq(new_user_session_path)
    end
  end
end