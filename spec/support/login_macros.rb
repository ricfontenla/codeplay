module LoginMacros
  def user_login
    admin = Admin.create!(email: 'ademir@codeplay.com', 
                          password: '987654')
    login_as admin, scope: :admin
  end
end