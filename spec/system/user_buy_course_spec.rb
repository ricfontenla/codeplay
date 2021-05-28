require 'rails_helper'

describe 'User buy a corse' do
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
                            duration: 40, course: course)
    user = User.create!(email: 'jane_doe@codeplay.com', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Cursos'
    click_on course.name
    click_on 'Comprar curso'

    expect(page).to have_content('Curso comprado com sucesso!')
    expect(page).to_not have_link('Comprar curso')
  end
end