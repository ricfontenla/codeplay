module LoginMacros
  def admin_login
    admin = Admin.create!(email: 'ademir@codeplay.com', 
                          password: '987654')
    login_as admin, scope: :admin
  end
end