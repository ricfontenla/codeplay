require 'rails_helper'

describe 'Visitor browses the application' do
  it 'and visit homepage' do
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    course = Course.create!(name: 'Ruby', 
                            description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', 
                            price: 10,
                            enrollment_deadline: 1.month.from_now, 
                            instructor: instructor)

    visit root_path

    expect(page).to have_css('h2', text: 'Boas vindas ao sistema de gestão de '\
                                         'cursos e aulas')
    expect(page).to have_content('Olá, visitante')
    expect(page).to have_link('Ruby', href: course_path(course))
    expect(page).to have_content('Um curso de Ruby')
    expect(page).to have_content('R$ 10,00')
  end

  it 'view and details of a course' do
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    course = Course.create!(name: 'Ruby', 
                            description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', 
                            price: 10,
                            enrollment_deadline: 1.month.from_now, 
                            instructor: instructor)

    visit root_path
    click_on 'Ruby'

    expect(page).to have_content('Ruby')
    expect(page).to have_content('Um curso de Ruby')
    expect(page).to have_content('RUBYBASIC') 
    expect(page).to have_content('R$ 10,00')
    expect(page).to have_content(1.month.from_now.strftime('%d/%m/%Y'))
    expect(page).to have_link('Fulano Fulano', href: instructor_path(instructor))
    expect(page).to have_link('Voltar', href: root_path)
  end
  
  xit 'and view lessons' do
  end

  xit 'and view details of lesson' do
  end

  xit 'and view details of a instructor' do
  end
end
