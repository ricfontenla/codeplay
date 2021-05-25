require 'rails_helper'

describe 'Admin deletes course' do
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
                            duration: 40, course: course)

    visit courses_path
    click_on course.name

    expect { click_on 'Deletar curso'}.to change { Course.count }.by(-1)
    expect(Lesson.last).to eq(nil)
    expect(current_path).to eq(courses_path)
    expect(page).to have_content('Curso apagado com sucesso')
  end
end