require 'rails_helper'

describe 'Admin edits course' do
  it 'sucessfully' do
    admin = Admin.create!(email: 'ademir@codeplay.com', 
                          password: '987654')
    instructor1 = Instructor.create!(name: 'Fulano Fulano', 
                                     email: 'fulano@codeplay.com.br', 
                                     bio: 'Dev e instrutor na Code Play')
    instructor2 = Instructor.create!(name: 'Sicrano Sicrano', 
                                     email: 'sicrano@codeplay.com.br', 
                                     bio: 'Dev e fundador na Code Play')
    course = Course.create!(name: 'Ruby', 
                            description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', 
                            price: 10,
                            enrollment_deadline: '22/12/2033', 
                            instructor: instructor1)
    
    login_as admin, scope: :admin
    visit root_path
    click_on 'Cursos'
    click_on  'Ruby'
    click_on 'Editar'
    fill_in 'Nome', with: 'Ruby on Rails'
    fill_in 'Descrição', with: 'Um curso de Ruby on Rails'
    fill_in 'Código', with: 'RUBYONRAILS'
    fill_in 'Preço', with: '30'
    fill_in 'Data limite de matrícula', with: Date.current
    select 'Sicrano Sicrano', from: 'Professor'
    click_on 'Salvar curso'

    expect(current_path).to eq(admin_course_path(course))
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('RUBYONRAILS')
    expect(page).to have_content('R$ 30,00')
    expect(page).to have_content(I18n.l Date.current)
    expect(page).to have_link('Sicrano Sicrano', href: instructor_path(instructor2))
    expect(page).to have_content('Curso editado com sucesso')
  end

  it 'attributes cannot be blank' do
    admin = Admin.create!(email: 'ademir@codeplay.com', 
                          password: '987654')
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                     email: 'fulano@codeplay.com.br', 
                                     bio: 'Dev e instrutor na Code Play')
    course = Course.create!(name: 'Ruby', 
                            description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', 
                            price: 10,
                            enrollment_deadline: '22/12/2033', 
                            instructor: instructor)

    login_as admin, scope: :admin
    visit admin_course_path(course)
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Preço', with: ''
    click_on 'Salvar curso'

    expect(page).to have_content('Editar Curso')
    expect(page).to have_content('não pode ficar em branco', count: 3)
    expect(page).to have_link('Cancelar', href: admin_course_path(course))
  end

  it 'and code must be uniq' do
    admin = Admin.create!(email: 'ademir@codeplay.com', 
                          password: '987654')
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    course = Course.create!(name: 'Ruby', 
                            description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', 
                            price: 10,
                            enrollment_deadline: '22/12/2033', 
                            instructor: instructor)
    Course.create!(name: 'Ruby on Rails',
                   description: 'Um curso de Ruby on Rails',
                   code: 'RUBYONRAILS', 
                   price: 20,
                   enrollment_deadline: '20/12/2033', 
                   instructor: instructor)

    login_as admin, scope: :admin
    visit admin_course_path(course)
    click_on 'Editar'
    fill_in 'Código', with: 'RUBYONRAILS'
    click_on 'Salvar curso'

    expect(page).to have_content('Editar Curso')
    expect(page).to have_content('já está em uso')
    expect(page).to have_link('Cancelar', href: admin_course_path(course))
  end
end
