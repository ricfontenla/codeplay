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
    lesson = Lesson.create!(name: 'Lógica de Programação', 
                            content: 'Conceitos de lógica de programação', 
                            duration:50, course: course)

    visit course_path(course)
    click_on lesson.name    
  
    expect {click_on 'Deletar' }.to change { Lesson.count }.by(-1)
    expect(page).to have_content('Não há aulas cadastradas neste curso')
    expect(page).to have_content('Aula deletada com sucesso')
  end
end