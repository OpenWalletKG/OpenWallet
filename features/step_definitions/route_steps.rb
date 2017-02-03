When(/^перехожу на главную страницу$/) do
  visit root_path
end

When(/^пользователь на странице регистрации$/) do
  visit ('/sign_up')
end

When(/^я перехожу на страницу почты mailcatcher$/) do
  visit('http://127.0.0.1:1080')
end

When(/^прикрепляю скан паспорта юр.лица$/) do
  page.attach_file("client_corporate_image", Rails.root + 'app/assets/images/beeline.png')
  sleep(0.5)
end

When(/^прикрепляю скан паспорта физ лица$/) do
  page.attach_file("client_individual_image", Rails.root + 'app/assets/images/megacom.png')
  sleep(0.5)
end

When(/^кликаю на письмо через xpath$/) do
  find(:xpath, "//*[@id='messages']/table/tbody/tr[1]/td[2]").click
  sleep(0.5)
end

When(/^перехожу на страницу письма уведомления для физического лица$/) do
  visit 'http://127.0.0.1:1080/messages/1.html'
  sleep(0.5)
end