require 'rails_helper'

describe 'user authentication' do
  context 'for courses' do
    it 'cannot enroll user into courses without login' do
      post enroll_user_course_path(1)

      expect(response).to redirect_to(new_user_session_path)
    end
  end
end