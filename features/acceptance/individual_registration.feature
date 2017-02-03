# language: ru
  Функционал: Пользователь может успешно регистрироваться в системе как
    физ.лицо

  Сценарий: Успешной регистрации пользователя
  Допустим пользователь на странице регистрации
  И выбираю в радио батон "fizik"
  И кликаю на "Продолжить"
  И ввожу в поле номер телефона
    | field                     | value     |
    | client_client_mobile      | 996996996 |
    | client_client_country     |  KGZ      |
  И кликаю на кнопку "Next"
  И ввожу данные в поля форм
    | field                               | value           |
    | client_client_email                 | jack@example.com|
    | client_individual_first_name        | Jack            |
    | client_individual_last_name         | Doe             |
    | client_individual_in                | 44444555557     |
    | client_individual_dob               | 12-10-1990      |
    | client_client_password              | 1515151515      |
    | client_client_password_confirmation | 1515151515      |
  И прикрепляю скан паспорта физ лица
  И кликаю на кнопку "Sign up"
  И вижу на странице "Привет"
  И кликаю на ссылку "Настройки аккаунта"
  И вижу на странице "Выход"
  И нажимает на кнопку "Выход"
