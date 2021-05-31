require 'rails_helper'

describe 'User buy a corse' do
  it 'successfully' do
    user = User.create!(email: 'jane_doe@codeplay.com', 
                        password: '123456')
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
                            duration: 40, 
                            course: course)

    login_as user, scope: :user
    visit root_path
    click_on course.name
    click_on 'Comprar'

    expect(page).to have_content('Curso comprado com sucesso')
    expect(page).to_not have_link('Comprar curso')
  end
end