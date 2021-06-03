require 'rails_helper'

describe 'Admin deletes lesson' do
  it 'sucessfully' do
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
                            duration:50, 
                            course: course)

    admin_login
    visit root_path
    click_on 'Cursos'
    click_on 'Ruby'
    click_on 'Lógica de Programação'
  
    expect {click_on 'Deletar' }.to change { Lesson.count }.by(-1)
    expect(page).to have_content('Não há aulas cadastradas neste curso')
    expect(page).to have_content('Aula deletada com sucesso')
  end
end