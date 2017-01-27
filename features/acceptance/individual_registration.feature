# language: ru
  Функционал: Пользователь может успешно регистрироваться в системе как
    физ.лицо

  Сценарий: Успешной регистрации пользователя
  Допустим пользователь на странице регистрации
  И выбираю в радио батон "fizik"
  И кликаю на "Продолжить"
  И ввожу в поле номер телефона
    | field                     | value  |
    | client_mobile             | 996996996|
  И кликаю на кнопку "Next"
  И ввожу данные в поля форм
    | field                               | value           |
    | client_email                        | jack@example.com|
    | client_entity_attributes_first_name | Jack            |
    | client_entity_attributes_last_name  | Doe             |
    | client_entity_attributes_inn        | 44444555557     |
    | client_entity_attributes_dob        | 12-10-1990      |
    | client_password                     | 1515151515      |
    | client_password_confirmation        | 1515151515      |
  И кликаю на кнопку "Sign up"
  И вижу на странице "Привет,"
  И нажимает на кнопку "Выход"
