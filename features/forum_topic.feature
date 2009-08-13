Функционал: Темы на форуме
  Чтобы пользователи могли обсуждать
  Важные вещи в отдельных темах

  Предыстория:
    Допустим у меня есть форум О молоке

  Сценарий: Просмотр темы разлогиненным
    Допустим я разлогинен
    И у меня есть тема Срок годности на форуме О молоке c описанием "что-то" и сообщением "Почему пропадает?"
    Если я иду в тему Срок годности
    То я должен видеть "О молоке"
    И я должен видеть "Срок годности"
    И я должен видеть "что-то"
    И я должен видеть "Почему пропадает"
    И я не должен видеть "Править"
    И я не должен видеть "Ответить"

  Сценарий: Просмотр темы модератором
    Допустим есть пользователь Тестер с паролем 123456
    И у меня есть тема Срок годности на форуме О молоке c описанием "что-то" и сообщением "Почему пропадает?", созданная пользователем Тестер
    И я залогинился, будучи модератором на форуме О молоке, как Модер
    Если я иду в тему Срок годности
    То я должен видеть "Править"
    И я должен видеть "Ответить"

  Сценарий: Создание темы
    Допустим я залогинился как Тестер
    И я зашел на форум О молоке
    Если я кликаю на "Новая тема"
    И я ввожу "Срок годности" в поле "Название"
    И я ввожу "вопрос возник" в поле "Описание"
    И я ввожу "Почему молоко пропадает?" в поле "Сообщение"
    И я нажимаю на "Создать"
    То я должен видеть "Тема успешно создана"
    И я должен быть в теме Срок годности

  Сценарий: Создание темы с ошибками
    Допустим я залогинился как Тестер
    И я зашел на форум О молоке
    Если я кликаю на "Новая тема"
    И я ввожу "" в поле "Название"
    И я ввожу "вопрос возник" в поле "Описание"
    И я ввожу "Почему молоко пропадает?" в поле "Сообщение"
    И я нажимаю на "Создать"
    То я должен видеть "сохранение не удалось"

  Сценарий: Создание темы без сообщения
    Допустим я залогинился как Тестер
    И я зашел на форум О молоке
    Если я кликаю на "Новая тема"
    И я ввожу "Срок годности" в поле "Название"
    И я ввожу "вопрос возник" в поле "Описание"
    И я ввожу "" в поле "Сообщение"
    И я нажимаю на "Создать"
    То я должен видеть "сохранение не удалось"
    И я должен видеть "Срок годности" в поле "Название"
    И я должен видеть "вопрос возник" в поле "Описание"
    И я должен видеть "" в поле "Сообщение"

  Сценарий: Редактирование темы
    Допустим я залогинился как Тестер
    И у меня есть тема Срок годности на форуме О молоке c описанием "что-то" и сообщением "Почему пропадает?", созданная пользователем Тестер
    Если я иду в редактирование темы Срок годности
    И я ввожу "Срок выпивания" в поле "Название"
    И я нажимаю на "Обновить"
    То я должен видеть "Тема успешно обновлена"

  Сценарий: Редактирование темы с ошибками
    Допустим я залогинился как Тестер
    И у меня есть тема Срок годности на форуме О молоке c описанием "что-то" и сообщением "Почему пропадает?", созданная пользователем Тестер
    Если я иду в редактирование темы Срок годности
    И я ввожу "" в поле "Название"
    И я нажимаю на "Обновить"
    То я должен видеть "сохранение не удалось"

  Сценарий: Удаление темы
    Допустим я залогинился как Тестер
    И у меня есть тема Срок годности на форуме О молоке c описанием "что-то" и сообщением "Почему пропадает?", созданная пользователем Тестер
    Если я иду в редактирование темы Срок годности
    И я нажимаю на "Удалить"
    То я должен увидеть "Тема успешно удалена"
