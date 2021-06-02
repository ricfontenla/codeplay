require 'rails_helper'

describe 'Admin view lessons' do
  it 'sucessfully' do
    admin = Admin.create!(email: 'ademir@codeplay.com', 
                          password: '987654')
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
    
    login_as admin, scope: :admin
    visit root_path
    click_on 'Cursos'
    click_on 'Ruby'

    expect(page).to have_content('Aulas neste curso:')
    expect(page).to have_content('Lógica de Programação')
    expect(page).to have_content('40 minutos')
    expect(page).to have_content('Tipos Primitivos')
    expect(page).to have_content('50 minutos')
  end

  it 'and view details' do
    admin = Admin.create!(email: 'ademir@codeplay.com', 
                          password: '987654')
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    course = Course.create!(name: 'Ruby', 
                            description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', 
                            price: 10,
                            enrollment_deadline: Date.current, 
                            instructor: instructor)
    lesson = Lesson.create!(name: 'Lógica de Programação', 
                            content: 'Conceitos de lógica de programação', 
                            duration: 40, 
                            course: course)
    Lesson.create!(name: 'Tipos Primitivos', 
                   content: 'Integer, Float, String, Boolean', 
                   duration: 50, 
                  course: course)

    login_as admin, scope: :admin
    visit admin_course_path(course)
    click_on 'Lógica de Programação'

    expect(current_path).to eq admin_course_lesson_path(course, lesson)
    expect(page).to have_content('Lógica de Programação')
    expect(page).to have_content('Conceitos de lógica de programação')
    expect(page).to have_content('40 minutos')
    expect(page).to have_link('Voltar', href: admin_course_path(course))
  end

  it 'and no lessons available' do
    admin = Admin.create!(email: 'ademir@codeplay.com', 
                          password: '987654')
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    course = Course.create!(name: 'Ruby', 
                            description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', 
                            price: 10,
                            enrollment_deadline: Date.current, 
                            instructor: instructor)

    login_as admin, scope: :admin    
    visit admin_course_path(course)
    
    expect(page).to have_content('Aulas neste curso:')
    expect(page).to have_content('Não há aulas cadastradas neste curso')
  end
end
