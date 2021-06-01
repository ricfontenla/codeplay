require 'rails_helper'

describe 'Admin view courses' do
  it 'successfully' do
    admin = Admin.create!(email: 'ademir@codeplay.com', 
                          password: '987654')
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    Course.create!(name: 'Ruby', 
                   description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', 
                   price: 10,
                   enrollment_deadline: 1.month.from_now, 
                   instructor: instructor)
    Course.create!(name: 'Ruby on Rails',
                   description: 'Um curso de Ruby on Rails',
                   code: 'RUBYONRAILS', 
                   price: 20,
                   enrollment_deadline: 2.months.from_now, 
                   instructor: instructor)
    
    login_as admin, scope: :admin
    visit root_path
    click_on 'Cursos'

    expect(page).to have_content('Cursos Cadastrados')
    expect(page).to have_content('Ruby')
    expect(page).to have_content('Um curso de Ruby')
    expect(page).to have_content('R$ 10,00')
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('R$ 20,00')
  end

  it 'and view details' do
    admin = Admin.create!(email: 'ademir@codeplay.com', 
                          password: '987654')
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    Course.create!(name: 'Ruby', 
                   description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', 
                   price: 10,
                   enrollment_deadline: 1.month.from_now, 
                   instructor: instructor)
    course = Course.create!(name: 'Ruby on Rails',
                            description: 'Um curso de Ruby on Rails',
                            code: 'RUBYONRAILS', 
                            price: 20,
                            enrollment_deadline: 2.months.from_now, 
                            instructor: instructor)

    login_as admin, scope: :admin
    visit admin_courses_path
    click_on 'Ruby on Rails'

    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('RUBYONRAILS')
    expect(page).to have_content('R$ 20,00')
    expect(page).to have_content(2.months.from_now.strftime("%d/%m/%Y"))
    expect(page).to have_link('Fulano Fulano', href: instructor_path(instructor))
    expect(page).to have_link('Voltar', href: admin_courses_path)
    expect(page).not_to have_link('Comprar', href: enroll_course_path(course))

  end

  it 'and no course is available' do
    admin = Admin.create!(email: 'ademir@codeplay.com', 
                          password: '987654')

    login_as admin, scope: :admin
    visit admin_courses_path

    expect(page).to have_content('Cursos Cadastrados')
    expect(page).to have_content('Nenhum curso disponível')
  end
end