When(/^перехожу на главную страницу$/) do
  visit root_path
end

When(/^пользователь на странице регистрации$/) do
  visit ('/sign_up')
end