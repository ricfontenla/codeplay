require 'rails_helper'

describe 'admin view instructors' do
  it 'sucessfully' do
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

    expect(page).to have_content('Fulano Fulano')
    expect(page).to have_content('Dev e instrutor na Code Play')
    expect(page).to have_content('Sicrano Sicrano')
    expect(page).to have_content('Dev e fundador na Code Play')
  end

  it 'and view details' do
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

    expect(page).to have_content('Fulano Fulano')
    expect(page).to have_content('fulano@codeplay.com.br')
    expect(page).to have_content('Dev e instrutor na Code Play')
    expect(page).to have_css("img[src*='profile1.jpeg']")
  end

  it 'no instructor registered' do
    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Nenhum professor cadastrado')
  end

  it 'and return to home page' do
    visit root_path
    click_on 'Professores'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  it 'and return to Professores' do
    instructor1 = Instructor.create!(name: 'Fulano Fulano', 
                                     email: 'fulano@codeplay.com.br', 
                                     bio: 'Dev e instrutor na Code Play')
    instructor1.profile_picture
                  .attach(io: File.open('spec/fixtures/profile1.jpeg'), 
                          filename: 'profile1.jpeg')

    visit root_path
    click_on 'Professores'
    click_on 'Fulano Fulano'
    click_on 'Voltar'

    expect(current_path).to eq instructors_path
  end
end