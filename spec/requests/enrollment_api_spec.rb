require 'rails_helper'

describe 'Enrollment API' do
  context 'GET /api/v1/courses/:code/enrollments' do
    it 'should get all enrollments from course' do
      user1 = User.create!(email: 'john_doe@codeplay.com',
                          password: '123456')
      user2 = User.create!(email: 'jane_doe@codeplay.com',
                          password: '123456')
      course = create(:course)
      Enrollment.create!(user: user1,
                         course: course,
                         price: course.price)
      Enrollment.create!(user: user2,
                         course: course,
                         price: course.price)

      get "/api/v1/courses/#{course.code}/enrollments"

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body.count).to eq(Enrollment.count)
      expect(parsed_body[0]['user']['email']).to eq(user1.email)
      expect(parsed_body[1]['user']['email']).to eq(user2.email)
      expect(response.body).to include(course.name)
    end

    it 'should return empty if no enrollments' do
      course = create(:course)

      get "/api/v1/courses/#{course.code}/enrollments"

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(response.body).to include('Nenhuma matrícula registrada para este curso')
    end

    xit 'should return 404 if course does not exists' do
    end
  end
end