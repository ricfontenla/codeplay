require 'rails_helper'

describe 'Admin edits instructors' do
  it 'sucessfully' do
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    instructor.profile_picture
                .attach(io: File.open('spec/fixtures/profile1.jpeg'), 
                        filename: 'profile1.jpeg')
            
    visit root_path
    click_on 'Professores'
    click_on 'Fulano Fulano'
    click_on 'Editar'
    
    fill_in 'Nome', with: 'Sicrano Sicrano'
    fill_in 'E-mail', with: 'sicrano@codeplay.com.br'
    fill_in 'Descrição', with: 'Dev e fundador na Code Play'
    attach_file 'Foto', Rails.root.join('spec/fixtures/profile2.jpg')
    click_on 'Cadastrar Professor'

    expect(current_path).to eq(instructor_path(instructor))
    expect(page).to have_content('Sicrano Sicrano')
    expect(page).to have_content('sicrano@codeplay.com.br')
    expect(page).to have_content('Dev e fundador na Code Play')
    expect(page).to have_css("img[src*='profile2.jpg']")
  end
  
  it 'attributes cannot be blank' do
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    instructor.profile_picture
                .attach(io: File.open('spec/fixtures/profile1.jpeg'), 
                        filename: 'profile1.jpeg')

    visit root_path
    click_on 'Professores'
    click_on 'Fulano Fulano'
    click_on 'Editar'
  
    fill_in 'Nome', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Cadastrar Professor'

    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  it 'and email must be uniq' do
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
              

    visit root_path
    click_on 'Professores'
    click_on 'Fulano Fulano'
    click_on 'Editar'

    fill_in 'E-mail', with: 'sicrano@codeplay.com.br'
    click_on 'Cadastrar Professor'

    expect(page).to have_content('já está em uso')
  end

  it 'and cancel' do
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    instructor.profile_picture
                .attach(io: File.open('spec/fixtures/profile1.jpeg'), 
                        filename: 'profile1.jpeg')

    visit root_path
    click_on 'Professores'
    click_on 'Fulano Fulano'
    click_on 'Editar'


    expect(page).to have_link(href: instructor_path(instructor))
  end
end
