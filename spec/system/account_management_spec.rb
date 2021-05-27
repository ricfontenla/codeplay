require 'rails_helper'

describe 'Account Management' do
  context 'register' do
    it 'with email and password' do
      visit root_path
      click_on 'Cadastre-se'
      fill_in 'Email', with: 'jane_doe@codeplay.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmar senha', with: '123456'
      click_on 'Criar Conta'

      expect(page).to have_content('Login efetuado com sucesso')
      expect(current_path).to eq(root_path)
      expect(page).to have_content('jane_doe@codeplay.com')
      expect(page).to_not have_link('Cadastre-se')
      expect(page).to have_link('Sair')
    end

    it 'and attributes cannot be blank' do
      visit new_user_registration_path
      click_on 'Criar Conta'

      expect(page).to have_content('Cadastro de usuário')
      expect(page).to have_content('não pode ficar em branco', count: 2)
    end

    it 'and Email is already in use' do
      User.create!(email: 'jane_doe@codeplay.com', password: '123456')

      visit new_user_registration_path
      fill_in 'Email', with: 'jane_doe@codeplay.com'
      click_on 'Criar Conta'

      expect(page).to have_content('Cadastro de usuário')
      expect(page).to have_content('já está em uso')
    end

    it 'and password not match confirmation' do
      visit new_user_registration_path
      fill_in 'Confirmar senha', with: '123456'
      click_on 'Criar Conta'

      expect(page).to have_content('Confirmar senha não é igual a')
      expect(page).to have_content('Cadastro de usuário')
    end
  end

  context 'Sign in' do
    it 'sucessfully' do
      User.create!(email: 'jane_doe@codeplay.com', password: '123456')

      visit root_path
      click_on 'Entrar'
      fill_in 'Email', with: 'jane_doe@codeplay.com'
      fill_in 'Senha', with: '123456'
      within 'form' do
        click_on 'Entrar'
      end

      expect(page).to have_content('Login efetuado com sucesso')
      expect(current_path).to eq(root_path)
      expect(page).to have_content('jane_doe@codeplay.com')
      expect(page).to_not have_link('Registrar me')
      expect(page).to_not have_link('Entrar')
      expect(page).to have_link('Sair')
    end
  end

  context 'loggout' do
    it 'sucessfully' do
      user = User.create!(email: 'jane_doe@codeplay.com', password: '123456')

      login_as user, scope: :user
      visit root_path
      click_on 'Sair'

      expect(page).to have_content('Saiu com sucesso')
      expect(current_path).to eq(root_path)
      expect(page).to_not have_content('jane_doe@codeplay.com')
      expect(page).to have_link('Cadastre-se')
      expect(page).to have_link('Entrar')
      expect(page).to_not have_link('Sair')
    end
  end
end