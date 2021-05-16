require 'rails_helper'

describe 'Admin registers instructors' do
  it 'from index page' do
    visit root_path
    click_on 'Professores'

    expect(page).to have_link('Cadastrar um Professor', 
                               href: new_instructor_path)
  end

  it 'sucessfully' do
    visit root_path
    click_on 'Professores'
    click_on 'Cadastrar um Professor'

    fill_in 'Nome', with: 'Fulano Fulano'
    fill_in 'E-mail', with: 'fulano@codeplay.com'
    fill_in 'Descrição', with: 'Dev e instrutor na Code Play'
    attach_file 'Foto', Rails.root.join('spec/fixtures/profile1.jpeg')
    click_on 'Cadastrar Professor'

    expect(current_path).to eq(instructor_path(Instructor.last))
    expect(page).to have_content('Fulano Fulano')
    expect(page).to have_content('fulano@codeplay.com')
    expect(page).to have_content('Dev e instrutor na Code Play')
    expect(page).to have_css("img[src*='profile1.jpeg']")
  end

  it 'attrubutes cannot be blank' do
    visit root_path
    click_on 'Professores'
    click_on 'Cadastrar um Professor'

    fill_in 'Nome', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Cadastrar Professor'

    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  it 'and email must be uniq' do
    Instructor.create!(name: 'Fulano Fulano', 
                       email: 'fulano@codeplay.com.br', 
                       bio: 'Dev e instrutor na Code Play')
    
    visit root_path
    click_on 'Professores'
    click_on 'Cadastrar um Professor'

    fill_in 'E-mail', with: 'fulano@codeplay.com.br'
    click_on 'Cadastrar Professor'

    expect(page).to have_content('já está em uso')
  end

  it 'and cancel' do
    visit root_path
    click_on 'Professores'
    click_on 'Cadastrar um Professor'
    click_on 'Cancelar'

    expect(current_path).to eq(instructors_path)
  end
end