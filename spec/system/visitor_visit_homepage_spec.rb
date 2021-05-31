require 'rails_helper'

describe 'Visitor visit homepage' do
  it 'successfully' do
    visit root_path

    expect(page).to have_css('h2', text: 'Boas vindas ao sistema de gestão de '\
                                         'cursos e aulas')
    expect(page).to have_content('Olá, visitante')
  end
end
