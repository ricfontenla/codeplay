require 'rails_helper'

describe 'Admin deletes instructors' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                     email: 'fulano@codeplay.com.br', 
                                     bio: 'Dev e instrutor na Code Play')
    instructor.profile_picture
                  .attach(io: File.open('spec/fixtures/profile1.jpeg'), 
                          filename: 'profile1.jpeg')
    
    admin_login
    visit root_path
    click_on 'Professores'
    click_on 'Fulano Fulano'
    
    expect { click_on 'Deletar' }.to change { Instructor.count }.by(-1) 
    expect(current_path).to eq(admin_instructors_path)
    expect(page).to have_content('Professor apagado com sucesso')
  end

  it 'and fails because because there are dependent courses' do
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    Course.create!(name: 'Ruby', 
                   description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', 
                   price: 10,
                   enrollment_deadline: 1.month.from_now, 
                   instructor: instructor)

    admin_login
    visit admin_instructors_path
    click_on 'Fulano Fulano'
    click_on 'Deletar'

    expect(page).to have_content('Este professor ainda possui cursos ativos')
  end
end