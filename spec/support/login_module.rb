module LoginModule
  def login(user)
    visit login_path
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: 'password'
    click_button 'ログイン'
  end
end
