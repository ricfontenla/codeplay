require 'rails_helper'

describe 'Admin registers instructors' do
  it 'sucessfully' do
    admin = Admin.create!(email: 'ademir@codeplay.com', 
                          password: '987654')

    login_as admin, scope: :admin
    visit root_path
    click_on 'Professores'
    click_on 'Cadastrar um Professor'
    fill_in 'Nome', with: 'Fulano Fulano'
    fill_in 'E-mail', with: 'fulano@codeplay.com'
    fill_in 'Descrição', with: 'Dev e instrutor na Code Play'
    attach_file 'Foto do perfil', Rails.root.join('spec/fixtures/profile1.jpeg')
    click_on 'Cadastrar Professor'

    expect(current_path).to eq(instructor_path(Instructor.last))
    expect(page).to have_content('Fulano Fulano')
    expect(page).to have_content('fulano@codeplay.com')
    expect(page).to have_content('Dev e instrutor na Code Play')
    expect(page).to have_css("img[src*='profile1.jpeg']")
    expect(page).to have_link('Voltar', href: instructors_path)
  end

  it 'and attributes cannot be blank' do
    admin = Admin.create!(email: 'ademir@codeplay.com', 
                          password: '987654')

    login_as admin, scope: :admin
    visit new_instructor_path
    click_on 'Cadastrar Professor'

    expect(page).to have_content('Novo Professor')
    expect(page).to have_content('não pode ficar em branco', count: 2)
    expect(page).to have_link('Cancelar', href: instructors_path)
  end

  it 'and email must be uniq' do
    admin = Admin.create!(email: 'ademir@codeplay.com', 
                          password: '987654')
    Instructor.create!(name: 'Fulano Fulano', 
                       email: 'fulano@codeplay.com.br', 
                       bio: 'Dev e instrutor na Code Play')
    
    login_as admin, scope: :admin
    visit new_instructor_path
    fill_in 'E-mail', with: 'fulano@codeplay.com.br'
    click_on 'Cadastrar Professor'

    expect(page).to have_content('Novo Professor')
    expect(page).to have_content('já está em uso')
    expect(page).to have_link('Cancelar', href: instructors_path)
  end
end