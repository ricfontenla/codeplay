require 'rails_helper'

describe 'Admin manages account' do
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
  end

  context 'and loggout' do
    it 'sucessfully' do
      admin = Admin.create!(email: 'ademir@codeplay.com', 
                            password: '987654')

      login_as admin, scope: :admin
      visit root_path
      click_on 'Sair'

      expect(page).to have_content('Saiu com sucesso')
      expect(current_path).to eq(root_path)
      expect(page).to have_link('Login de Usuário')
      expect(page).to have_link('Login de Administrador')
      expect(page).to_not have_content('ademir@codeplay.com')
      expect(page).to_not have_link('Sair')
      expect(page).to_not have_link('Cursos')
      expect(page).to_not have_link('Instructor')
    end
  end

  context 'and forgot password' do
    it 'and try to recover' do
      admin = Admin.create!(email: 'ademir@codeplay.com', 
                            password: '987654')
  
      visit new_admin_session_path
      click_on 'Esqueceu sua senha?'
      fill_in 'Email', with: 'ademir@codeplay.com'
      click_on 'Enviar instruções para trocar a senha'
  
      expect(current_path).to eq(new_admin_session_path)
      expect(page).to have_content('Dentro de minutos, você receberá um e-mail com instruções para a troca da sua senha')
    end
    
    it 'and reset password' do
      admin = Admin.create!(email: 'ademir@codeplay.com', 
                            password: '987654')
      token = admin.send_reset_password_instructions

      visit edit_admin_password_path(reset_password_token: token)
      fill_in 'Nova senha', with: '123456'
      fill_in 'Confirmar nova senha', with: '123456'
      click_on 'Alterar minha senha'
      expect(page).to have_content('Sua senha foi alterada com sucesso. Você está logado.')
      expect(current_path).to eq (root_path)
    end  
  end
end