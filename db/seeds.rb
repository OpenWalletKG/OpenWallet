p
p "SEEDS STARTED:"
role_agent0 = Role.create(definition: "Агент 0")
role_agent = Role.create(definition: "Агент")
role_fiz = Role.create(definition: "Физ.лицо")
role_supplier = Role.create(definition: "Поставщик")

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


person = Individual.create(first_name: 'Dima', last_name: 'Z', dob: Time.now, inn: 'I00001')
person_account = Account.create(number: person.inn)
Client.create(mobile:'996700007411', password:'asdfasdf', country: 'KGZ', entity_id: person.id, entity_type: "Individual" , role_id:3, account_id: person_account.id)

Employee.create(position: 'Директор')
Employee.create(position: 'Бухгалтер')

vasya = Individual.create(first_name: 'Vasya', last_name: 'T', dob: Time.now, inn: 'I00002')
vasya_account = Account.create(number: vasya.inn)
company = Corporate.create(registration_number: 'R11111', bin: 'B1', address: 'asdfasdf')

CorporateIndividual.create(corporate_id: company.id, individual_id: person.id, employee_id: 1)
CorporateIndividual.create(corporate_id: company.id, individual_id: vasya.id, employee_id: 2)
company_account = Account.create(number: company.bin)


Client.create(mobile:'996999999999', password:'asdfasdf', country: 'KGZ', entity_id: company.id, entity_type: "Corporate" , role_id:2, account_id: company_account.id)

Client.create(mobile: '092029213321', password:'asdfasdf', country: 'KGZ', entity_id: vasya.id, entity_type:"Individual", role_id: 3, account_id: vasya_account.id)

#test for existance
person = Individual.create(first_name: 'Dima', last_name: 'Z', dob: Time.now, inn: 'I00001')
Client.create(mobile: '092-029-213321', password:'asdfasdf', country: 'KGZ', entity_id: vasya.id, entity_type:"Individual", role_id: 3)
company = Corporate.create(registration_number: 'R11111', bin: 'B1', address: 'asdfasdf')

# test for mobile phone entries

person = Individual.create(first_name: 'Azamat', last_name: 'J', dob: Time.now, inn: '200001')
person_account = Account.create(number: person.inn)
Client.create(mobile:'996-700-007411', password:'asdfasdf', country: 'KGZ', entity_id: person.id, entity_type: "Individual" , role_id:3, account_id: person_account.id)