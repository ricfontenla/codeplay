require 'rails_helper'

describe 'admin view instructors' do
  it 'sucessfully' do
    Instructor.create!(name: 'Henrique Morato', 
                       email: 'henrique.morato@campuscode.com.br', 
                       bio: 'Dev e instrutor na Campus Code', 
                       profile_picture: '')
    Instructor.create!(name: 'João Almeida', 
                       email: 'joao.almeida@campuscode.com.br', 
                       bio: 'Dev e fundador na Campus Code',
                       profile_picture: '')
  
    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Henrique Morato')
    expect(page).to have_content('henrique.morato@campuscode.com.br')
    expect(page).to have_content('Dev e instrutor na Campus Code')
    expect(page).to have_content('João Almeida')
    expect(page).to have_content('joao.almeida@campuscode.com.br')
    expect(page).to have_content('Dev e fundador na Campus Code')
  end
end