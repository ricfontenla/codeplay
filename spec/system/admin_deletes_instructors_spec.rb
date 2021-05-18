require 'rails_helper'

describe 'Admin deletes instructors' do
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
    click_on 'Deletar'
     
    expect(current_path).to eq(instructors_path)
    expect(Instructor.count).to eq(0)
  end
end