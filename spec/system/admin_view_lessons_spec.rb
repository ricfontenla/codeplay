require 'rails_helper'

describe 'Admin view lessons' do
  it 'sucessfully' do
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', 
                            instructor: instructor)
    Lesson.create!(name: 'Lógica de Programação', 
                   content: 'Revisão de conceitos de lógica de programação', 
                   course: course)
    Lesson.create!(name: 'Tipos Primitivos', 
                   content: 'Tipagem em Ruby: Integer, Float, String, Boolean', 
                   course: course)

    visit root_path
    click_on 'Cursos'
    click_on 'Ruby'

    expect(page).to have_content('Aulas neste curso:')
    expect(page).to have_content('Lógica de Programação')
    expect(page).to have_content('Tipos Primitivos')
    expect(page).to have_content('Tipagem em Ruby: Integer, Float, String, Boolean')
  end

  it 'and no registered lessons' do
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', 
                            instructor: instructor)
    
    visit root_path
    click_on 'Cursos'
    click_on 'Ruby'  
    
    expect(page).to have_content('Aulas neste curso:')
    expect(page).to have_content('Não há aulas cadastradas neste curso')
  end
end
