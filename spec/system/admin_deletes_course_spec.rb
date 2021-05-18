require 'rails_helper'

describe 'Admin deletes course' do
  it 'sucessfully' do
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033')

    visit courses_path
    click_on course.name
    expect { click_on 'Deletar'}.to change { Course.count }.by(-1)
    expect(current_path).to eq(courses_path)
    expect(page).to have_content('Curso apagado com sucesso')
  end
end