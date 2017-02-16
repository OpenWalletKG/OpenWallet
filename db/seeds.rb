p
p "SEEDS STARTED:"
role_agent0 = Role.create(definition: "Агент 0", permission: Role::ROLE_PERMISSIONS[Role::AGENT_0])
role_agent = Role.create(definition: "Агент", permission: Role::ROLE_PERMISSIONS[Role::AGENT])
role_fiz = Role.create(definition: "Физ.лицо", permission: Role::ROLE_PERMISSIONS[Role::INDIVIDUAL])
role_supplier = Role.create(definition: "Поставщик", permission: Role::ROLE_PERMISSIONS[Role::SUPPLIER])

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