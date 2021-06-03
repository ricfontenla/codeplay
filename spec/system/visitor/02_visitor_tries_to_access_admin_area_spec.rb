require 'rails_helper'

describe 'Visitor tries to access admin area' do
  context 'of instructors' do
    it 'and cannot view index' do
      visit admin_instructors_path

      expect(current_path).to eq(new_admin_session_path)
    end

    it 'and cannot view instructor details' do
      visit admin_instructor_path(1)

      expect(current_path).to eq(new_admin_session_path)
    end

    it 'and cannot register a new one' do
      visit new_admin_instructor_path

      expect(current_path).to eq(new_admin_session_path)
    end

    it 'and cannot edit informations' do
      visit edit_admin_instructor_path(1)

      expect(current_path).to eq(new_admin_session_path)
    end
  end

  context 'of courses' do
    it 'and cannot view index' do
      visit admin_courses_path

      expect(current_path).to eq(new_admin_session_path)
    end

    it 'and cannot view course details' do
      visit admin_course_path(1)

      expect(current_path).to eq(new_admin_session_path)
    end

    it 'and cannot register a new one' do
      visit new_admin_course_path

      expect(current_path).to eq(new_admin_session_path)
    end

    it 'and cannot edit informations' do
      visit edit_admin_course_path(1)

      expect(current_path).to eq(new_admin_session_path)
    end
  end

  context 'of lessons' do
    it 'and cannot view lesson details' do
      visit admin_course_lesson_path(1, 1)

      expect(current_path).to eq(new_admin_session_path)
    end

    it 'and cannot register a new one' do
      visit new_admin_course_lesson_path(1)

      expect(current_path).to eq(new_admin_session_path)
    end

    it 'and cannot edit informations' do
      visit edit_admin_course_lesson_path(1, 1)

      expect(current_path).to eq(new_admin_session_path)
    end
  end
end