require 'rails_helper'

describe 'User visits profile' do
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
                            enrollment_deadline: 1.month.from_now, 
                            instructor: instructor)
    enrollment = Enrollment.create!(user: user, 
                                    course: course, 
                                    price: course.price)

    login_as user, scope: :user
    visit root_path
    click_on 'Meu Perfil'

    expect(page).to have_content('Meus Cursos')
    expect(page).to have_link('Ruby', href: user_course_path(course))
    expect(page).to have_content(I18n.l enrollment.created_at, :format => :long)
    expect(page).to have_content('R$ 10,00')
  end

  it 'and no enrolled courses' do
    user = User.create!(email: 'jane_doe@codeplay.com', 
                        password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Meu Perfil'

    expect(page).to have_content('Meus Cursos')
    expect(page).to have_content('Você ainda não possui nenhum curso')
  end
end