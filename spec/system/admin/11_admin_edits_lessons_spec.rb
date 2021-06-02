require 'rails_helper'

describe 'admin edits lessons' do
  it 'successfully' do
    admin = Admin.create!(email: 'ademir@codeplay.com', 
                          password: '987654')
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    course = Course.create!(name: 'Ruby', 
                            description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', 
                            price: 10,
                            enrollment_deadline: '22/12/2033', 
                            instructor: instructor)
    lesson = Lesson.create!(name: 'Lógica de Programação', 
                            content: 'Conceitos de lógica de programação', 
                            duration: 50, 
                            course: course)
    
    login_as admin, scope: :admin
    visit root_path
    click_on 'Cursos'
    click_on 'Ruby'
    click_on 'Lógica de Programação'
    click_on 'Editar aula'
    fill_in 'Nome', with: 'Tipos Primitivos'
    fill_in 'Conteúdo', with: 'Tipagem em Ruby: Integer, Float, String, Boolean'
    fill_in 'Duração', with: 40
    click_on 'Salvar aula'

    expect(page).to have_link('Tipos Primitivos', 
                              href: admin_course_lesson_path(course, lesson))
    expect(page).to have_content('40 minutos')
    expect(page).to have_content('Aula atualizada com sucesso')
    expect(page).not_to have_content('Lógica de Programação')
    expect(page).not_to have_content('50 minutos')


  end

  it 'and cannot be blank' do
    admin = Admin.create!(email: 'ademir@codeplay.com', 
                          password: '987654')
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    course = Course.create!(name: 'Ruby', 
                            description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', 
                            price: 10,
                            enrollment_deadline: '22/12/2033', 
                            instructor: instructor)
    lesson = Lesson.create!(name: 'Lógica de Programação', 
                            content: 'Conceitos de lógica de programação', 
                            duration: 50, 
                            course: course)

    login_as admin, scope: :admin
    visit admin_course_lesson_path(course, lesson)
    click_on 'Editar aula'
    fill_in 'Nome', with: ''
    fill_in 'Duração', with: ''
    click_on 'Salvar aula'

    expect(page).to have_content('Editar Aula')
    expect(page).to have_content('não pode ficar em branco', count: 2)
    expect(page).to have_link('Cancelar', href: admin_course_path(course))
  end
end