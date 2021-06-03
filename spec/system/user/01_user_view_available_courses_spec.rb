require 'rails_helper'

describe 'user view courses on homepage' do
  it 'courses with enrollment still available' do
    user = User.create!(email: 'jane_doe@codeplay.com', 
                        password: '123456')
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    available_course = Course.create!(name: 'Ruby', 
                                      description: 'Um curso de Ruby',
                                      code: 'RUBYBASIC', 
                                      price: 10,
                                      enrollment_deadline: 1.month.from_now, 
                                      instructor: instructor)
    unavailable_course = Course.create!(name: 'HTML', 
                                        description: 'Um curso de HTML',
                                        code: 'HTMLBASIC', 
                                        price: 12,
                                        enrollment_deadline: 1.day.ago, 
                                        instructor: instructor)

    login_as user, scope: :user
    visit root_path

    expect(page).to have_link('Ruby', href: user_course_path(available_course))
    expect(page).to have_content('Um curso de Ruby')
    expect(page).to have_content('R$ 10,00')
    expect(page).not_to have_content('HTML')
    expect(page).not_to have_content('Um curso de HTML')
    expect(page).not_to have_content('R$ 12,00')
  end

  it 'and no courses available' do
    user = User.create!(email: 'jane_doe@codeplay.com', 
                        password: '123456')
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                  bio: 'Dev e instrutor na Code Play')
    unavailable_course = Course.create!(name: 'HTML', 
                                        description: 'Um curso de HTML',
                                        code: 'HTMLBASIC', 
                                        price: 12,
                                        enrollment_deadline: 1.day.ago, 
                                        instructor: instructor)

    login_as user, scope: :user
    visit root_path

    expect(page).to have_content('Nenhum curso disponível')
  end
end