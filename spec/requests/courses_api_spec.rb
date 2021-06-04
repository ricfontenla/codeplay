require 'rails_helper'

describe 'Courses API' do
  context 'GET /api/v1/courses' do
    it 'should get courses' do
      instructor = Instructor.create!(name: 'Fulano Fulano', 
                                      email: 'fulano@codeplay.com.br', 
                                      bio: 'Dev e instrutor na Code Play')
      Course.create!(name: 'Ruby', 
                     description: 'Um curso de Ruby',
                     code: 'RUBYBASIC', 
                     price: 10,
                     enrollment_deadline: 1.month.from_now, 
                     instructor: instructor)
      Course.create!(name: 'Ruby on Rails',
                    description: 'Um curso de Ruby on Rails',
                    code: 'RUBYONRAILS', 
                    price: 20,
                    enrollment_deadline: 2.months.from_now, 
                    instructor: instructor)

      get '/api/v1/courses'

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body.count).to eq(Course.count)
      expect(parsed_body[0]['name']).to eq('Ruby')
      expect(parsed_body[1]['name']).to eq('Ruby on Rails')
    end

    it 'returns no courses' do
      get '/api/v1/courses'

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(parsed_body).to be_empty
    end
  end

  context "GET /api/v1/courses/:code" do
    it 'should return a course' do
     instructor = Instructor.create!(name: 'Fulano Fulano', 
                                      email: 'fulano@codeplay.com.br', 
                                      bio: 'Dev e instrutor na Code Play')
      course = Course.create!(name: 'Ruby', 
                              description: 'Um curso de Ruby',
                              code: 'RUBYBASIC', 
                              price: 10,
                              enrollment_deadline: 1.month.from_now, 
                              instructor: instructor)
      Course.create!(name: 'Ruby on Rails',
                    description: 'Um curso de Ruby on Rails',
                    code: 'RUBYONRAILS', 
                    price: 20,
                    enrollment_deadline: 2.months.from_now, 
                    instructor: instructor)

      get "/api/v1/courses/#{course.code}"

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body['code']).to eq('RUBYBASIC')
      expect(response.body).to_not include('RUBYONRAILS')
    end

    it 'should not found course by random code' do
      get '/api/v1/courses/ABC1234'

      expect(response).to have_http_status(404)
    end
  end

  context 'POST /api/v1/courses' do
    it 'should create a course' do
      instructor = Instructor.create!(name: 'Fulano Fulano', 
                                      email: 'fulano@codeplay.com.br', 
                                      bio: 'Dev e instrutor na Code Play')

      post '/api/v1/courses', params: { 
        course: { name: 'Ruby on Rails', 
                  description: 'Um curso de Ruby on Rails',
                  code: 'RUBYONRAILS', 
                  price: '10', 
                  instructor_id: instructor.id, 
                  enrollment_deadline: Date.current } 
      }  
      
      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      expect(parsed_body['name']).to eq('Ruby on Rails')
      expect(parsed_body['description']).to eq('Um curso de Ruby on Rails')
      expect(parsed_body['code']).to eq('RUBYONRAILS')
      expect(parsed_body['price']).to eq('10.0')
      expect(parsed_body['instructor_id']).to eq(1)
      expect(parsed_body['enrollment_deadline']).to eq(Date.current.strftime('%Y-%m-%d'))
    end

    it 'should not create a course with missing params' do
      instructor = Instructor.create!(name: 'Fulano Fulano', 
                                      email: 'fulano@codeplay.com.br', 
                                      bio: 'Dev e instrutor na Code Play')

      post '/api/v1/courses'

      expect(response).to have_http_status(422)
    end

    it 'should not create a course with repited code' do
      instructor = Instructor.create!(name: 'Fulano Fulano', 
                                      email: 'fulano@codeplay.com.br', 
                                      bio: 'Dev e instrutor na Code Play')
      course = Course.create!(name: 'Ruby', 
                              description: 'Um curso de Ruby',
                              code: 'RUBYBASIC', 
                              price: 10,
                              enrollment_deadline: 1.month.from_now, 
                              instructor: instructor)

      post '/api/v1/courses', params: { 
        course: {name: 'Ruby', 
                 description: 'Um curso de Ruby',
                 code: 'RUBYBASIC', 
                 price: 10,
                 enrollment_deadline: 1.month.from_now, 
                 instructor_id: instructor.id} 
      }

      expect(response).to have_http_status(412)
    end
  end

  context "PATCH /api/v1/course/:code" do
    it 'should update a course' do
      instructor = Instructor.create!(name: 'Fulano Fulano', 
                                      email: 'fulano@codeplay.com.br', 
                                      bio: 'Dev e instrutor na Code Play')
      course = Course.create!(name: 'Ruby', 
                              description: 'Um curso de Ruby',
                              code: 'RUBYBASIC', 
                              price: 10,
                              enrollment_deadline: 1.month.from_now, 
                              instructor: instructor)

      patch "/api/v1/courses/#{course.code}", params: { 
        course: { name: 'Ruby on Rails',
                  description: 'Um curso de Ruby on Rails',
                  code: 'RUBYONRAILS', 
                  price: 20,
                  enrollment_deadline: Date.current, 
                  instructor: instructor } 
      }

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body['name']).to eq('Ruby on Rails')
      expect(parsed_body['description']).to eq('Um curso de Ruby on Rails')
      expect(parsed_body['code']).to eq('RUBYONRAILS')
      expect(parsed_body['price']).to eq('20.0')
      expect(parsed_body['enrollment_deadline']).to eq(Date.current.strftime('%Y-%m-%d'))
    end

    it 'should not update a course with missing params' do
      instructor = Instructor.create!(name: 'Fulano Fulano', 
                                      email: 'fulano@codeplay.com.br', 
                                      bio: 'Dev e instrutor na Code Play')
      course = Course.create!(name: 'Ruby', 
                              description: 'Um curso de Ruby',
                              code: 'RUBYBASIC', 
                              price: 10,
                              enrollment_deadline: 1.month.from_now, 
                              instructor: instructor)

      patch "/api/v1/courses/#{course.code}"

      expect(response).to have_http_status(422)
    end

    it 'should not update a course with repited params' do
      instructor = Instructor.create!(name: 'Fulano Fulano', 
                                      email: 'fulano@codeplay.com.br', 
                                      bio: 'Dev e instrutor na Code Play')
      course = Course.create!(name: 'Ruby', 
                              description: 'Um curso de Ruby',
                              code: 'RUBYBASIC', 
                              price: 10,
                              enrollment_deadline: 1.month.from_now, 
                              instructor: instructor)
      Course.create!(name: 'Ruby on Rails',
                    description: 'Um curso de Ruby on Rails',
                    code: 'RUBYONRAILS', 
                    price: 20,
                    enrollment_deadline: 2.months.from_now, 
                    instructor: instructor)

      patch "/api/v1/courses/#{course.code}", params: { 
        course: { name: 'Ruby on Rails',
                  description: 'Um curso de Ruby on Rails',
                  code: 'RUBYONRAILS', 
                  price: 20,
                  enrollment_deadline: 2.months.from_now, 
                  instructor_id: instructor.id }
       }

      expect(response).to have_http_status(412)
    end
  end

  context 'DELETE /api/v1/courses/:code' do
    it 'should delete a course' do
      instructor = Instructor.create!(name: 'Fulano Fulano', 
                                      email: 'fulano@codeplay.com.br', 
                                      bio: 'Dev e instrutor na Code Play')
      course = Course.create!(name: 'Ruby', 
                              description: 'Um curso de Ruby',
                              code: 'RUBYBASIC', 
                              price: 10,
                              enrollment_deadline: 1.month.from_now, 
                              instructor: instructor)
      Course.create!(name: 'Ruby on Rails',
                    description: 'Um curso de Ruby on Rails',
                    code: 'RUBYONRAILS', 
                    price: 20,
                    enrollment_deadline: 2.months.from_now, 
                    instructor: instructor)

      delete "/api/v1/courses/#{course.code}"
      
      expect(response).to have_http_status(204)
      expect(Course.all.count).to eq(1)
    end

    it 'should not delete a course with wrong id' do
      instructor = Instructor.create!(name: 'Fulano Fulano', 
                                      email: 'fulano@codeplay.com.br', 
                                      bio: 'Dev e instrutor na Code Play')
      course = Course.create!(name: 'Ruby', 
                              description: 'Um curso de Ruby',
                              code: 'RUBYBASIC', 
                              price: 10,
                              enrollment_deadline: 1.month.from_now, 
                              instructor: instructor)
      Course.create!(name: 'Ruby on Rails',
                    description: 'Um curso de Ruby on Rails',
                    code: 'RUBYONRAILS', 
                    price: 20,
                    enrollment_deadline: 2.months.from_now, 
                    instructor: instructor)

      delete "/api/v1/courses/0"
      
      expect(response).to have_http_status(404)
      expect(Course.all.count).to eq(2)
    end    
  end
end
