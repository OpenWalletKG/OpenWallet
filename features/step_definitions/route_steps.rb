When(/^перехожу на главную страницу$/) do
  visit root_path
end

When(/^пользователь на странице регистрации$/) do
  visit ('/sign_up')
end

When(/^я перехожу на страницу почты mailcatcher$/) do
  visit('http://127.0.0.1:1080')
end