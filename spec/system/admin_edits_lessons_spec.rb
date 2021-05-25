require 'rails_helper'

describe 'admin edits lessons' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', 
                            instructor: instructor)
    lesson = Lesson.create!(name: 'Lógica de Programação', 
                            content: 'Conceitos de lógica de programação', 
                            duration: 50, course: course)

    visit root_path
    click_on 'Cursos'
    click_on course.name
    click_on lesson.name
    click_on 'Editar aula'
    fill_in 'Nome', with: 'Tipos Primitivos'
    fill_in 'Conteúdo', with: 'Tipagem em Ruby: Integer, Float, String, Boolean'
    fill_in 'Duração', with: 40
    click_on 'Salvar aula'

    expect(page).to have_link('Tipos Primitivos', 
                               href: course_lesson_path(course, lesson))
    expect(page).to have_content('40 minutos')
    expect(page).to have_content('Aula atualizada com sucesso')
  end

  it 'cannot be blank' do
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', 
                            instructor: instructor)
    lesson = Lesson.create!(name: 'Lógica de Programação', 
                            content: 'Conceitos de lógica de programação', 
                            duration: 50, course: course)

    visit course_lesson_path(course, lesson)
    click_on 'Editar aula'
    fill_in 'Nome', with: ''
    fill_in 'Duração', with: ''
    click_on 'Salvar aula'

    expect(page).to have_content('Editar Aula')
    expect(page).to have_content('não pode ficar em branco', count: 2)
    expect(page).to have_link('Cancelar', href: course_path(course))
  end
end