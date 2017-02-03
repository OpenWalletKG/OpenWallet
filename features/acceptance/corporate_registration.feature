# language: ru
Функционал: Пользователь может успешно регистрироваться в системе как
  юр.лицо

  Сценарий: Успешной регистрации Юр.лица
    Допустим пользователь на странице регистрации
    И выбираю в радио батон "jurik"
    И кликаю на "Продолжить"
    И ввожу в поле номер телефона
      | field                     | value       |
      | client_client_mobile      | 77085434234 |
      | client_client_country     |  KAZ        |
    И кликаю на кнопку "Next"
    И ввожу данные в поля форм
      | field                                       | value                  |
      | client_client_email                         | info@tengri.kz         |
      | client_corporate_registration_number        | KZT00123344R           |
      | client_corporate_address                    | Almaty, R.Bakieva 232  |
      | client_corporate_in                         | 2344444334325          |
      | client_client_password                      | 1515151515             |
      | client_client_password_confirmation         | 1515151515             |
    И прикрепляю файл
    И кликаю на кнопку "Sign up"
    И вижу на странице "Привет"
    И кликаю на ссылку "Настройки аккаунта"
    И вижу на странице "Выход"
    И нажимает на кнопку "Выход"

