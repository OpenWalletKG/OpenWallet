When(/^я перехожу на главную страницу$/) do
  visit root_path
end

When(/^вижу главную страницу$/) do
  page.assert_text('Вход')
end