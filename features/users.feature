Функционал: Работа с пользователями
  Чтобы различать пользователей
  Они должны иметь учетные записи
  И использовать их для входа на сайт

  Сценарий: Регистрация
    Допустим я зашел на главную
    Если я кликаю на "зарегистрироваться"
    И я ввожу "Вася" в поле "Логин"
    И я ввожу "123456" в поле "Пароль"
    И я ввожу "123456" в поле "Повторите пароль"
    И я выбираю "мужской" из поля "Пол"
    И я нажимаю на "Зарегистрироваться"
    То я должен увидеть "Пользователь зарегистрирован"
    И я должен увидеть "Вы вошли как Вася"

  Сценарий: Регистрация с ошибками
    Допустим я зашел на главную
    Если я кликаю на "зарегистрироваться"
    И я ввожу "Вася^%E$^T%R" в поле "Логин"
    И я ввожу "123456" в поле "Пароль"
    И я ввожу "123456" в поле "Повторите пароль"
    И я нажимаю на "Зарегистрироваться"
    То я должен увидеть "Регистрация пользователя"

  Сценарий: Вход на сайт
    Допустим есть пользователь Вася с паролем 123456
    И я зашел на главную
    Если я кликаю на "войти"
    И я ввожу "Вася" в поле "Логин"
    И я ввожу "123456" в поле "Пароль"
    И я нажимаю на "Войти"
    То я должен увидеть "Вы вошли на сайт"

  Сценарий: Вход на сайт с ошибками
    Допустим есть пользователь Вася с паролем 123456
    И я зашел на главную
    Если я кликаю на "войти"
    И я ввожу "Вася" в поле "Логин"
    И я нажимаю на "Войти"
    То я должен увидеть "Ошибка входа"

  Сценарий: Выход с сайта
    Допустим я залогинился как Вася
    Если я кликаю на "выйти"
    То я должен увидеть "Вы успешно прекратили сеанс работы"

  Сценарий: Смена пароля
    Допустим я залогинился как Вася
    Если я кликаю на "аккаунт"
    И я ввожу "фываолдж" в поле "Пароль"
    И я ввожу "фываолдж" в поле "Повторите пароль"
    И я нажимаю на "Сохранить"
    И я кликаю на "выйти"
    И я кликаю на "войти"
    И я ввожу "Вася" в поле "Логин"
    И я ввожу "фываолдж" в поле "Пароль"
    И я нажимаю на "Войти"
    То я должен увидеть "Вы вошли на сайт"

  Сценарий: Редактирование профиля
    Допустим я залогинился как Вася
    И у меня есть группа 7371, существующая с 2007 года
    Если я кликаю на "профиль"
    И я выбираю "7371" из поля "Группа"
    И я нажимаю на "Сохранить"
    И я иду на страничку пользователя Вася
    То я должен увидеть "7371"
