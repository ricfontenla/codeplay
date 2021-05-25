require 'rails_helper'

describe 'Admin view lessons' do
  it 'sucessfully' do
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', 
                            instructor: instructor)
    lesson1 = Lesson.create!(name: 'Lógica de Programação', 
                             content: 'Conceitos de lógica de programação', 
                             duration: 40, course: course)
    lesson2 = Lesson.create!(name: 'Tipos Primitivos', 
                             content: 'Integer, Float, String, Boolean', 
                             duration: 50 ,course: course)

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
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', 
                            instructor: instructor)
    lesson = Lesson.create!(name: 'Lógica de Programação', 
                            content: 'Conceitos de lógica de programação', 
                            duration: 40, course: course)
    Lesson.create!(name: 'Tipos Primitivos', 
                   content: 'Integer, Float, String, Boolean', 
                   duration: 50, course: course)

    visit course_path(course)
    click_on lesson.name

    expect(current_path).to eq course_lesson_path(course, lesson)
    expect(page).to have_content(lesson.name)
    expect(page).to have_content(lesson.content)
    expect(page).to have_content('40 minutos')
    expect(page).to have_link('Voltar', href: course_path(course))
  end

  it 'and no lessons available' do
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', 
                            instructor: instructor)
    
    visit root_path
    click_on 'Cursos'
    click_on 'Ruby'  
    
    expect(page).to have_content('Aulas neste curso:')
    expect(page).to have_content('Não há aulas cadastradas neste curso')
  end
end
