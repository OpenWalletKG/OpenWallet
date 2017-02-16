p
p "Test SEEDS STARTED:"
role_agent0 = Role.create(definition: "Агент 0")
role_agent = Role.create(definition: "Агент")
role_fiz = Role.create(definition: "Физ.лицо")
role_supplier = Role.create(definition: "Поставщик")
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
# add = Address.create!
# acc = Account.create!(number: 'KZ416201722040076840')
# ent = Corporate.create!(registration_number: '16585812',in:'950740000130')
# #user1 = Client.create!(mobile: '996533121212', country: "kgs", email: 'user1@example.com', password: '123456', password_confirmation: '123456',entity_type: "Corporate", entity_id: 1,account_id: 1, role_id: 2,address_id: 1)
# user = Client.create!( mobile: '996533121212', country: "kgs", account_id: acc.id, role_id:role_agent0.id , entity_type: ent, entity_id: ent.id, email: "user1@example.com", password: '123456', password_confirmation: '123456')

Employee.create(position: 'Директор' )