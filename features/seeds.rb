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

Employee.create(position: 'Директор' )