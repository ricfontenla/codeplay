require 'rails_helper'

describe 'Admin deletes lesson' do
  it 'sucessfully' do
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

    visit courses_path(course)
    click_on course.name
    click_on 'Deletar'

    expect(page).to have_content('Não há aulas cadastradas neste curso')
    expect(page).to have_content('Aula deletada com sucesso')
  end
end