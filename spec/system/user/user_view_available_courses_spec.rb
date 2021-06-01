require 'rails_helper'

describe 'Student view courses on homepage' do
  it 'courses with enrollment still available' do
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    available_course = Course.create!(name: 'Ruby', 
                                      description: 'Um curso de Ruby',
                                      code: 'RUBYBASIC', 
                                      price: 10,
                                      enrollment_deadline: 1.month.from_now, 
                                      instructor: instructor)
    unavailable_course = Course.create!(name: 'HTML', 
                                        description: 'Um curso de HTML',
                                        code: 'HTMLBASIC', 
                                        price: 12,
                                        enrollment_deadline: 1.day.ago, 
                                        instructor: instructor)
    user = User.create!(email: 'jane_doe@codeplay.com', 
                        password: '123456')

    visit root_path

    expect(page).to have_link('Ruby', href: course_path(available_course))
    expect(page).to have_content('Um curso de Ruby')
    expect(page).to have_content('R$ 10,00')
    expect(page).not_to have_content('HTML')
    expect(page).not_to have_content('Um curso de HTML')
    expect(page).not_to have_content('R$ 12,00')
  end

  it 'and view enrollment link' do
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
    
    login_as user, scope: :user
    visit root_path
    click_on 'Ruby'

    expect(page).to have_link('Comprar')
    expect(page).not_to have_link('Editar curso', href: edit_course_path(course))
    expect(page).not_to have_link('Deletar curso', href: course_path(course))
    expect(page).not_to have_link('Cadastrar uma aula', href: new_course_lesson_path(course))
  end

  it 'and does not view enrollment if deadline is over' do
    # curso com data limite ultrapassada mas com usuario logado não deve exibir o link
    user = User.create!(email: 'jane_doe@codeplay.com', 
                        password: '123456')
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    course = Course.create!(name: 'Ruby', 
                                      description: 'Um curso de Ruby',
                                      code: 'RUBYBASIC', 
                                      price: 10,
                                      enrollment_deadline: 1.day.ago, 
                                      instructor: instructor)
    
    login_as user, scope: :user
    visit course_path(course) 

    expect(page).not_to have_link('Comprar')
    expect(page).to have_content('O prazo para adquirir este curso terminou')
  end

  it 'must be signed in to enroll' do
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    available_course = Course.create!(name: 'Ruby', 
                                      description: 'Um curso de Ruby',
                                      code: 'RUBYBASIC', 
                                      price: 10,
                                      enrollment_deadline: 1.month.from_now, 
                                      instructor: instructor)
    
    visit root_path
    click_on 'Ruby'

    expect(page).not_to have_link('Comprar')
    expect(page).to have_content('Faça login para comprar esse curso')
    expect(page).to have_link('login', href: new_user_session_path)
  end

  it 'and buy a course' do
    user = User.create!(email: 'jane_doe@codeplay.com', 
                        password: '123456')
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    available_course = Course.create!(name: 'Ruby', 
                                      description: 'Um curso de Ruby',
                                      code: 'RUBYBASIC', 
                                      price: 10,
                                      enrollment_deadline: 1.month.from_now, 
                                      instructor: instructor)
    other_course = Course.create!(name: 'Elixir', 
                                  description: 'Um curso de Elixir',
                                  code: 'ELIXIRBASIC', 
                                  price: 20,
                                  enrollment_deadline: 1.month.from_now, 
                                  instructor: instructor)

    login_as user, scope: :user
    visit root_path
    click_on 'Ruby'
    click_on 'Comprar'

    expect(page).to have_content('Curso comprado com sucesso') 
    expect(current_path).to eq(my_enrollments_courses_path)
    expect(page).to have_content('Ruby')
    expect(page).to have_content('R$ 10,00')
    expect(page).not_to have_content('Elixir')
    expect(page).not_to have_content('R$ 20,00')
  end

  it 'and cannot buy a course twice' do
    #em enrolment => validates :course, uniqueness: { scope: :user }
    user = User.create!(email: 'jane_doe@codeplay.com', 
                        password: '123456')
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    course = Course.create!(name: 'Ruby', 
                            description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: 1.month.from_now, 
                            instructor: instructor)
    lesson = Lesson.create!(name: 'Lógica de Programação', 
                            content: 'Conceitos de lógica de programação', 
                            duration: 40, 
                            course: course)
    Enrollment.create!(user: user, 
                       course: course)

    login_as user, scope: :user
    visit root_path
    click_on 'Ruby'

    expect(page).to_not have_link('Comprar')
    expect(page).to have_link('Lógica de Programação')
  end
end