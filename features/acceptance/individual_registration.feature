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
  И кликаю на кнопку "Sign up"
  И вижу на странице "Привет"
#  И нажимает на кнопку "Выход"

#  Сценарий: Подтверждения письма присланное на почту
  Если я перехожу на страницу почты mailcatcher
  То кликаю на письмо через xpath
  И перехожу на страницу письма уведомления для физического лица
  И должен увидеть текст "You can confirm your account email through the link below:"
  И кликаю на ссылку "Confirm my account"
  И перехожу на главную страницу
  И кликаю на "Настройки аккаунта"
  И должен увидеть текст "Ваша почта подтверждена"
  И я перехожу на страницу почты mailcatcher
  И кликаю на ссылку "Clear"
  И кликаю на алерт "Ok"
