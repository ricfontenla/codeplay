require 'rails_helper'

describe 'Admin edits instructors' do
  it 'sucessfully' do
    admin = Admin.create!(email: 'ademir@codeplay.com', 
                          password: '987654')
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    instructor.profile_picture
                .attach(io: File.open('spec/fixtures/profile1.jpeg'), 
                        filename: 'profile1.jpeg')
    
    login_as admin, scope: :admin
    visit root_path
    click_on 'Professores'
    click_on instructor.name
    click_on 'Editar'
    fill_in 'Nome', with: 'Sicrano Sicrano'
    fill_in 'E-mail', with: 'sicrano@codeplay.com.br'
    fill_in 'Descrição', with: 'Dev e fundador na Code Play'
    attach_file 'Foto do perfil', Rails.root.join('spec/fixtures/profile2.jpg')
    click_on 'Salvar Professor'

    expect(current_path).to eq(instructor_path(instructor))
    expect(page).to have_content('Sicrano Sicrano')
    expect(page).to have_content('sicrano@codeplay.com.br')
    expect(page).to have_content('Dev e fundador na Code Play')
    expect(page).to have_css("img[src*='profile2.jpg']")
    expect(page).to have_content('Professor editado com sucesso')
  end
  
  it 'attributes cannot be blank' do
    admin = Admin.create!(email: 'ademir@codeplay.com', 
                          password: '987654')
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    instructor.profile_picture
                .attach(io: File.open('spec/fixtures/profile1.jpeg'), 
                        filename: 'profile1.jpeg')

    login_as admin, scope: :admin
    visit instructor_path(instructor)
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'E-mail', with: ''
    click_on 'Salvar Professor'

    expect(page).to have_content('Editar Professor')
    expect(page).to have_content('não pode ficar em branco', count: 2)
    expect(page).to have_link('Cancelar', href: instructor_path(instructor))
  end

  it 'and email must be uniq' do
    admin = Admin.create!(email: 'ademir@codeplay.com', 
                          password: '987654')
    instructor1 = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    instructor1.profile_picture
                 .attach(io: File.open('spec/fixtures/profile1.jpeg'), 
                         filename: 'profile1.jpeg')
    instructor2 = Instructor.create!(name: 'Sicrano Sicrano', 
                                    email: 'sicrano@codeplay.com.br', 
                                    bio: 'Dev e fundador na Code Play')
    instructor2.profile_picture
                  .attach(io: File.open('spec/fixtures/profile2.jpg'), 
                          filename: 'profile2.jpg')
              
    login_as admin, scope: :admin
    visit instructor_path(instructor1)
    click_on 'Editar'
    fill_in 'E-mail', with: 'sicrano@codeplay.com.br'
    click_on 'Salvar Professor'

    expect(page).to have_content('Editar Professor')
    expect(page).to have_content('já está em uso')
    expect(page).to have_link('Cancelar', href: instructor_path(instructor1))
  end
end
