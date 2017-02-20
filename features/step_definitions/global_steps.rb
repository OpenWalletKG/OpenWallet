When(/^кликаю на алерт "([^"]*)"$/) do |arg|
  page.driver.browser.switch_to.alert.accept
  sleep(0.5)
end

When(/^кликаю на ссылку "([^"]*)"$/) do |link|
  click_link link
  sleep(0.5)
end

When(/^кликаю на кнопку "([^"]*)"$/) do |button|
  click_button button
end

When(/^ввожу в поле "([^"]*)" текст "([^"]*)"$/) do |field, value|
  fill_in field, with:value
  sleep(0.5)
end

When(/^должен увидеть текст "([^"]*)"$/) do |text|
  sleep(0.5)
  page.assert_text(text)
end

When(/^выбираю из списка "([^"]*)" в поле "([^"]*)"$/) do |value, field|
  page.select(value, :from => field)
  sleep(0.5)
end

When(/^выбираю в радио батон "([^"]*)" в поле "([^"]*)"$/) do |value, field|
  choose(value)
  sleep(0.5)
end

When(/^должен не найти текст "([^"]*)"$/) do |text|
  page.assert_no_text(text)
  sleep(0.5)
end


When(/^кликаю на "([^"]*)"$/) do |arg|
  click_on(arg)
  sleep(0.5)
end

When(/^перехожу на другую вкладку браузера$/) do
  # Find our target window
  sleep(5)
  handle = page.driver.find_window("Esdp20163")
  page.driver.browser.switch_to.window(handle)
  sleep(0.5)
  # Close it
  #   close_tab = page.driver.find_window("Входящие-nic.pet.esdp@gmail.com-Gmail")
  #   page.driver.browser.close(close_tab)

  # Have the Selenium driver point to another window
  # last_handle = page.driver.browser.window_handles.last
  # page.driver.browser.switch_to.window(last_handle)
end


When(/^выбираю в радио батон "([^"]*)"$/) do |value|
  choose(value)
  (0.5)
end

When(/^пользователь вводит номер телефона$/) do |table|
  # table is a table.hashes.keys # => [:field, :value]
  pending
end

When(/^ввожу в поле номер телефона$/) do |table|
  within('#new_client') do
    for row in table.hashes
      fill_in row[:field], :with => row[:value]
    end
  end
end

When(/^ввожу в поле счета "([^"]*)" текст "([^"]*)"$/) do |field, value|
  fill_in field, with:value
  sleep(0.5)
end


When(/^ввожу данные в поля форм$/) do |table|
  within('#new_client') do
    for row in table.hashes
      fill_in row[:field], :with => row[:value]
    end
  end
end

When(/^нажимает на кнопку "([^"]*)"$/) do |button|
  click_link(button)
end

When(/^открываю pdf "([^"]*)"$/) do |arg|
  click_link(arg)
  temp_pdf = Tempfile.new('pdf')
  temp_pdf << page.source.force_encoding('UTF-8')
  temp_pdf.close
  pdf_text = PDF::PdfToText.new(temp_pdf.path)
  page.driver.instance_variable_set('@body', pdf_text.get_text)
  sleep(3)
  switch_to_window(windows.first)
end

When(/^пользователь вводит не существующий счет в поле "([^"]*)" текст "([^"]*)"$/) do |field, value|
  fill_in field, with:value
end

When /^обновляю страницу$/ do
  page.evaluate_script("window.location.reload()");
  sleep(0.5)
end
