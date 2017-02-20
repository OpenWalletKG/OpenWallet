Before('@login_agent') do
  visit new_user_session_path
  fill_in "number", with:"558126394"
  fill_in "Пароль",with: "123456"
  click_button "Войти"
end

After('@logout') do
  if page.assert_text?("Привет")
    click_on('Выйти')
  end
end