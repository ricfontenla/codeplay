require 'rails_helper'

describe 'User view courses details' do
  it 'and view enrollment link' do
    user = User.create!(email: 'jane_doe@codeplay.com', 
                        password: '123456')
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    course = Course.create!(name: 'Ruby', 
                            description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', 
                            price: 10,
                            enrollment_deadline: 1.month.from_now, 
                            instructor: instructor)
    
    login_as user, scope: :user
    visit root_path
    click_on 'Ruby'

    expect(page).to have_link('Comprar')
    expect(current_path).to eq(user_course_path(course))
  end

  it 'and does not view enrollment if deadline is over' do
    user = User.create!(email: 'jane_doe@codeplay.com', 
                        password: '123456')
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    course = Course.create!(name: 'Ruby', 
                            description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', 
                            price: 10,
                            enrollment_deadline: 1.day.ago, 
                            instructor: instructor)
    
    login_as user, scope: :user
    visit user_course_path(course) 

    expect(page).not_to have_link('Comprar')
    expect(page).to have_content('O prazo para adquirir este curso terminou')
  end

  it 'must be signed in to enroll' do
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    available_course = Course.create!(name: 'Ruby', 
                                      description: 'Um curso de Ruby',
                                      code: 'RUBYBASIC', 
                                      price: 10,
                                      enrollment_deadline: 1.month.from_now, 
                                      instructor: instructor)
    
    visit root_path
    click_on 'Ruby'

    expect(page).not_to have_link('Comprar')
    expect(page).to have_content('Faça login para comprar esse curso')
    expect(page).to have_link('login', href: new_user_session_path)
  end
end