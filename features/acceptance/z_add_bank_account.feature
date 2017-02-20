# language: ru
Функционал: Пользователь может Добавить банковский счет

# При запуске теста запустите mailcatcher
  Сценарий: Успешного, не успешного и удаление банковского счета
    И я перехожу на страницу почты mailcatcher
    И кликаю на ссылку "Clear"
    И кликаю на алерт "Ok"
    Допустим пользователь на странице регистрации
    И выбираю в радио батон "jurik"
    И кликаю на "Продолжить"
    И ввожу в поле номер телефона
      | field                                       | value                  |
      | client_client_mobile                        | 77085434234            |
      | client_client_country                       |  KAZ                   |
      | client_client_email                         | info@tengri.kz         |
      | client_corporate_registration_number        |  16585812              |
      | client_corporate_in                         |  950740000130          |
      | client_client_password                      | 1515151515             |
      | client_client_password_confirmation         | 1515151515             |
    И прикрепляю скан паспорта юр.лица
    И открываю pdf "Лицензионное соглашение"
    И кликаю на кнопку "Зарегистрироваться"
    И ввожу в поле счета "pin" текст "1234"
    И кликаю на кнопку "Подтвердить"
    И вижу на странице "Выход"
    И кликаю на ссылку "Мои платежные системы"
    И ввожу в поле счета "Введите номер счета" текст "KZ966200122030000339"
    И ввожу в поле счета "Название счета" текст "Детский Дом Максима"
    И кликаю на "Cохранить"
    И должен увидеть текст "Номер банковского счета успешно добавлен!"
    И обновляю страницу
    И пользователь вводит не существующий счет в поле "Введите номер счета" текст "898799898979"
    И ввожу в поле счета "Название счета" текст "Счет отсутствует"
    И кликаю на "Cохранить"
    И должен увидеть текст "Номер банковского счета не найден!"
    И обновляю страницу
    И нажимает на кнопку "Удалить счет"
    И должен не найти текст "Детский Дом Максима"
    И нажимает на кнопку "Выход"



