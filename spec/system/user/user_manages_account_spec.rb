require 'rails_helper'

describe 'User manages account' do
  context 'and register' do
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
      expect(page).to have_link('Sair')
      expect(page).to have_link('Meu Perfil')
      expect(page).to_not have_link('Cadastre-se')
      expect(page).to_not have_link('Login de Usuário')
      expect(page).to_not have_link('Login de Administrador')
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

      expect(page).to have_content('Cadastro de usuário')
      expect(page).to have_content('Confirmar senha não é igual a')
    end
  end

  context 'and sign in' do
    it 'sucessfully' do
      Admin.create!(email: 'ademir@codeplay.com', 
                    password: '987654')

      visit root_path
      click_on 'Login de Administrador'
      fill_in 'Email', with: 'ademir@codeplay.com'
      fill_in 'Senha', with: '987654'
      click_on 'Entrar'

      expect(page).to have_content('Login efetuado com sucesso')
      expect(current_path).to eq(root_path)
      expect(page).to have_content('ademir@codeplay.com')
      expect(page).to have_link('Professores', href: instructors_path)
      expect(page).to have_link('Cursos', href: courses_path)
      expect(page).to have_link('Sair', href: destroy_admin_session_path)
      expect(page).to_not have_link('Login de Usuário')
      expect(page).to_not have_link('Login de Administrador')
      
    end

    it 'and email or password invalid' do
      visit root_path
      click_on 'Login de Administrador'
      click_on 'Entrar'

      expect(page).to have_content('Email ou senha inválida.')
    end
  end

  context 'and loggout' do
    it 'sucessfully' do
      user = User.create!(email: 'jane_doe@codeplay.com', 
                            password: '987654')

      login_as user, scope: :user
      visit root_path
      click_on 'Sair'

      expect(page).to have_content('Saiu com sucesso')
      expect(current_path).to eq(root_path)
      expect(page).to have_content('Cadastre-se')
      expect(page).to have_link('Login de Usuário')
      expect(page).to have_link('Login de Administrador')
      expect(page).to_not have_content('jane_doe@codeplay.com')
      expect(page).to_not have_content('Meu Perfil')
      expect(page).to_not have_link('Sair')
      expect(page).to_not have_link('Cursos')
      expect(page).to_not have_link('Instructor')
    end
  end

  context 'and forgot password' do
    it 'and try to recover' do
      user = User.create!(email: 'jane_doe@codeplay.com', 
                          password: '987654')
  
      visit new_user_session_path
      click_on 'Esqueceu sua senha?'
      fill_in 'Email', with: 'jane_doe@codeplay.com'
      click_on 'Enviar instruções para trocar a senha'
  
      expect(current_path).to eq(new_user_session_path)
      expect(page).to have_content('Dentro de minutos, você receberá um e-mail com instruções para a troca da sua senha')
    end
    
    it 'and reset password' do
      user = User.create!(email: 'jane_doe@codeplay.com', 
                          password: '987654')
      token = user.send_reset_password_instructions

      visit edit_user_password_path(reset_password_token: token)
      fill_in 'Nova senha', with: '123456'
      fill_in 'Confirmar nova senha', with: '123456'
      click_on 'Alterar minha senha'
      expect(page).to have_content('Sua senha foi alterada com sucesso. Você está logado.')
      expect(current_path).to eq (root_path)
    end  
  end
end