RolesAction.destroy_all
Action.destroy_all

$line_width = 60
$action_space = 3
$action_symbol = "-> "

def print_head(title)
  title += " " if title.length % 2 != 0
  lines = $line_width - 2 - title.length / 2
  puts
  print "-" * lines
  print " #{ title } "
  puts "-" * lines
  puts
end

def print_action( title )
  print " " * $action_space
  print $action_symbol
  puts "#{title}"
  puts
end

print_head "SEEDS:"
print_head "Роли:"

Role.destroy_all

role_agent0 = Role.new
role_agent0.init_permissions( :DO_EMISSION, :SELL )
role_agent0.register_role_as( :AGENT_0 )
permissions = role_agent0.list_permissions.join(", ")
print_action "Создана роль Агент 0 с правами:  [#{ permissions }]"

role_agent = Role.new
role_agent.init_permissions( :DO_EMISSION, :SELL, :DO_TRANSFER )
role_agent.register_role_as( :AGENT )
permissions = role_agent.list_permissions.join(", ")
print_action "Создана роль Агент с правами:  [#{ permissions }]"

role_fiz = Role.new
role_fiz.init_permissions( :BUY, :SELL, :ACCEPT_TRANSFER, :DO_TRANSFER, :DO_PAYMENT )
role_fiz.register_role_as( :INDIVIDUAL )
permissions = role_fiz.list_permissions.join(", ")
print_action "Создана роль Физ.лицо с правами:  [#{ permissions }]"

role_supplier = Role.new
role_supplier.init_permissions( :SELL, :ACCEPT_PAYMENT )
role_supplier.register_role_as( :SUPPLIER )
permissions = role_supplier.list_permissions.join(", ")
print_action "Создана роль Поставщик с правами:  [#{ permissions }]"

Bank.create!(name: "Tengri", plugin: "EsbClient")
Bank.create!(name: "Visa", plugin: "VisaClient")

action_emission = Action.create(description: "Ввод денег на СЭД агента")
action_buy = Action.create(description: "Покупка")
action_sell = Action.create(description: "Продажа")
action_transfer = Action.create(description: "Перевод")
action_recieve_transfer = Action.create(description: "Принять перевод")
action_send_payment = Action.create(description: "Отправить платеж")
action_recieve_transfer = Action.create(description: "Принять платеж")
action_withdraw = Action.create(description: "Вывод денег на банковский счет из СЭД")

role_agent0.actions << action_emission
role_agent0.actions << action_buy
role_agent0.actions << action_sell
role_agent.actions << action_buy
role_agent.actions << action_sell
role_fiz.actions << action_buy
role_fiz.actions << action_sell


# RolesAction.create(role_id: role_agent0, action_id: action_sell.id)
image_path = "#{Rails.root}/app/assets/images/fixtures/no_photo.jpg"
image_file = File.new(image_path)

Employee.create(position: 'Директор' )

# Корреспондентский счёт системы
CorrespondentAccount.create(balance: 0.to_d)