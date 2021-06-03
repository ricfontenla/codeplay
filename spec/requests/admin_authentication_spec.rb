require 'rails_helper'

describe 'admin authentication' do
  context 'for instructors' do
    it 'cannot access create whithout login' do
      post admin_instructors_path, params: { instructor: { name:'John' } }

      expect(response).to redirect_to(new_admin_session_path)
    end

    it 'cannot access update whithout login' do
      patch admin_instructor_path(1)

      expect(response).to redirect_to(new_admin_session_path)
    end

    it 'cannot access destroy whithout login' do
      delete  admin_instructor_path(1)

      expect(response).to redirect_to(new_admin_session_path)
    end
  end

  context 'for courses' do
    it 'cannot access create whitout login' do
      post admin_courses_path, params: { course: { name:'Python' } }
      
      expect(response).to redirect_to(new_admin_session_path)
    end
  end

  it 'cannot access update whithout login' do
    patch admin_course_path(1)

    expect(response).to redirect_to(new_admin_session_path)
  end

  it 'cannot access destroy whithout login' do
    delete  admin_course_path(1)

    expect(response).to redirect_to(new_admin_session_path)
  end

  context 'for lessons' do
    it 'cannot access create whitout login' do
      post admin_course_lessons_path(1), params: { course: { name:'Python' } }
      
      expect(response).to redirect_to(new_admin_session_path)
    end
  end

  it 'cannot access update whithout login' do
    patch admin_course_lesson_path(1, 1)

    expect(response).to redirect_to(new_admin_session_path)
  end

  it 'cannot access destroy whithout login' do
    delete  admin_course_lesson_path(1, 1)

    expect(response).to redirect_to(new_admin_session_path)
  end
end