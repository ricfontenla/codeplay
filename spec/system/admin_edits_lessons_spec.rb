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
    Lesson.create!(name: 'Lógica de Programação', 
                   content: 'Revisão de conceitos de lógica de programação', 
                   course: course)

    visit course_path(course)
    click_on 'Editar aula'
    fill_in 'Nome', with: 'Tipos Primitivos'
    fill_in 'Conteúdo', with: 'Tipagem em Ruby: Integer, Float, String, Boolean'
    click_on 'Salvar aula'

    expect(page).to have_content('Tipos Primitivos')
    expect(page).to have_content('Tipagem em Ruby: Integer, Float, String, Boolean')
  end
end