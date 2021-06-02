require 'rails_helper'

describe 'user view lessons' do
  xit 'sucessfully' do
  end

  it 'and cannot view lesson details whitout enrollment' do
    user = User.create!(email: 'jane_doe@codeplay.com', 
                        password: '123456')
    instructor = Instructor.create!(name: 'Fulano Fulano', 
                                    email: 'fulano@codeplay.com.br', 
                                    bio: 'Dev e instrutor na Code Play')
    course = Course.create!(name: 'Ruby', 
                            description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: 1.month.from_now, 
                            instructor: instructor)
    Lesson.create!(name: 'Lógica de Programação', 
                   content: 'Conceitos de lógica de programação', 
                   duration: 40, 
                   course: course)

    login_as user, scope: :user
    visit root_path
    click_on 'Ruby'

    expect(page).to_not have_link('Lógica de Programação')
    expect(page).to have_content('Lógica de Programação')
  end

  xit 'and cannot access lesson path without enrollment' do
    # protejer o link
  end

end