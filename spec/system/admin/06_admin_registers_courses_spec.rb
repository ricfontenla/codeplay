require 'rails_helper'

describe 'Admin registers courses' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')

    admin_login
    visit root_path
    click_on 'Cursos'
    click_on 'Cadastrar um Curso'
    fill_in 'Nome', with: 'Ruby on Rails'
    fill_in 'Descrição', with: 'Um curso de Ruby on Rails'
    fill_in 'Código', with: 'RUBYONRAILS'
    fill_in 'Preço', with: '30'
    fill_in 'Data limite de matrícula', with: Date.current
    select 'Fulano Fulano', from: 'Professor'
    click_on 'Criar curso'

    expect(current_path).to eq(admin_course_path(Course.last))
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('RUBYONRAILS')
    expect(page).to have_content('R$ 30,00')
    expect(page).to have_content(I18n.l Date.current)
    expect(page).to have_link('Fulano Fulano', href: admin_instructor_path(instructor))
  end

  it 'and attributes cannot be blank' do
    admin_login
    visit new_admin_course_path
    click_on 'Criar curso'

    expect(page).to have_content('Novo Curso')
    expect(page).to have_content('não pode ficar em branco', count: 4)
    expect(page).to have_link('Cancelar', href: admin_courses_path)
  end

  it 'and code must be unique' do
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    Course.create!(name: 'Ruby', 
                   description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', 
                   price: 10,
                   enrollment_deadline: '22/12/2033', 
                   instructor: instructor)

    admin_login
    visit new_admin_course_path
    fill_in 'Código', with: 'RUBYBASIC'
    click_on 'Criar curso'

    expect(page).to have_content('Novo Curso')
    expect(page).to have_content('já está em uso')
    expect(page).to have_link('Cancelar', href: admin_courses_path)
  end
end
