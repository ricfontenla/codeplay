require 'rails_helper'

describe 'Admin registers lessons' do
  it 'sucessfully' do
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', 
                            instructor: instructor)

    visit root_path
    click_on 'Cursos'
    click_on course.name
    click_on 'Cadastrar uma aula'
    fill_in 'Nome', with: 'Lógica de Programação'
    fill_in'Duração', with: 50
    fill_in 'Conteúdo', with: 'Revisão de lógica de programação em Ruby'
    click_on 'Cadastrar aula'
   
    expect(current_path).to eq course_path(course)
    expect(page).to have_content('Lógica de Programação')
    expect(page).to have_content('50 minutos')
  end

  it 'and name cannot be blank' do
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', 
                            instructor: instructor)

    visit course_path(course)
    click_on 'Cadastrar uma aula'
    click_on 'Cadastrar aula'

    expect(page).to have_content('Nova Aula')
    expect(page).to have_content('não pode ficar em branco')
    expect(page).to have_link('Cancelar', href: course_path(course))
  end
end
