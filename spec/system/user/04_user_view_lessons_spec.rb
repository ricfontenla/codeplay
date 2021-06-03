require 'rails_helper'

describe 'user view lessons' do
  it 'sucessfully' do
    user = User.create!(email: 'jane_doe@codeplay.com', 
                        password: '123456')
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    course = Course.create!(name: 'Ruby', 
                            description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', 
                            price: 10,
                            enrollment_deadline: Date.current, 
                            instructor: instructor)
    lesson1 = Lesson.create!(name: 'Lógica de Programação', 
                             content: 'Conceitos de lógica de programação', 
                             duration: 40, 
                             course: course)
    lesson2 = Lesson.create!(name: 'Tipos Primitivos', 
                             content: 'Integer, Float, String, Boolean', 
                             duration: 50, 
                             course: course)
    
    login_as user, scope: :user
    visit root_path
    click_on 'Ruby'

    expect(page).to have_content('Aulas neste curso:')
    expect(page).to have_content('Lógica de Programação')
    expect(page).to have_content('40 minutos')
    expect(page).to have_content('Tipos Primitivos')
    expect(page).to have_content('50 minutos')
  end

  it 'and view details' do
    user = User.create!(email: 'jane_doe@codeplay.com', 
                        password: '123456')
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    course = Course.create!(name: 'Ruby', 
                            description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: 1.month.from_now, 
                            instructor: instructor)
    lesson = Lesson.create!(name: 'Lógica de Programação', 
                            content: 'Conceitos de lógica de programação', 
                            duration: 40, 
                            course: course)
    Enrollment.create!(user: user, 
                      course: course, 
                      price: course.price)

    login_as user, scope: :user
    visit user_course_lesson_path(course, lesson)
    
    expect(page).to have_content('Lógica de Programação')
    expect(page).to have_content('40 minutos')
    expect(page).to have_content('Conceitos de lógica de programação')
  end

  it 'and cannot view lesson details whitout enrollment' do
    user = User.create!(email: 'jane_doe@codeplay.com', 
                        password: '123456')
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    course = Course.create!(name: 'Ruby', 
                            description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: 1.month.from_now, 
                            instructor: instructor)
    Lesson.create!(name: 'Lógica de Programação', 
                   content: 'Conceitos de lógica de programação', 
                   duration: 40, 
                   course: course)

    login_as user, scope: :user
    visit root_path
    click_on 'Ruby'

    expect(page).to_not have_link('Lógica de Programação')
    expect(page).to have_content('Lógica de Programação')
  end

  it 'and no lessons available' do
    user = User.create!(email: 'jane_doe@codeplay.com', 
                        password: '123456')
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    course = Course.create!(name: 'Ruby', 
                            description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: 1.month.from_now, 
                            instructor: instructor)

    login_as user, scope: :user
    visit user_course_path(course)
    
    expect(page).to have_content('Aulas neste curso:')
    expect(page).to have_content('Não há aulas cadastradas neste curso')
  end
end