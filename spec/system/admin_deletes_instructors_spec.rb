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
    
    expect { click_on 'Deletar' }.to change { Instructor.count }.by(-1) 
    expect(current_path).to eq(instructors_path)
    expect(page).to have_content('Professor apagado com sucesso')
  end

  it 'and cannot delete a instructor with courses' do
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', 
                   instructor: instructor)
    
    visit instructors_path
    click_on 'Fulano Fulano'
    click_on 'Deletar'

    expect(page).to have_content('Este professor ainda possui cursos ativos')
  end
end