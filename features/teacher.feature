Функционал: Информация о преподавателях
  Чтобы пользователи могли получать информацию
  о преподавателях и их контактные данные
  нужно хранить всё это и предоставлять в пользование

  Предыстория:
    Допустим у меня есть преподаватель Алексей Никитин, доступный по телефону 111-111-11
    И у меня есть преподаватель Борис Луговцов

  Сценарий: Просмотр списка преподавателей
    Если я иду в список преподавателей
    То я должен увидеть "Алексей"
    И я должен увидеть "Никитин"
    И я должен увидеть "Борис"
    И я должен увидеть "Луговцов"

  Сценарий: Просмотр странички преподавателя
    Если я иду на страничку преподавателя Алексей Никитин
    То я должен увидеть "Алексей Никитин"
    И я должен увидеть "111-111-11"

  Сценарий: Создание странички преподавателя
    Допустим я зашел в список преподавателей
    Если я кликаю на "Добавить преподавателя"
    И я ввожу "Галина" в поле "Имя"
    И я ввожу "Басаченко" в поле "Фамилия"
    И я ввожу "galia@baca4enko.ru" в поле "E-mail"
    И я нажимаю на "Добавить"
    То я должен быть на страничке преподавателя Галина Басаченко
    И я должен видеть "Преподаватель успешно добавлен"
    И я должен видеть "galia@baca4enko.ru"

  Сценарий: Создание странички преподавателя с ошибками
    Допустим я зашел в список преподавателей
    Если я кликаю на "Добавить преподавателя"
    И я ввожу "" в поле "Имя"
    И я ввожу "Басаченко" в поле "Фамилия"
    И я нажимаю на "Добавить"
    То я должен увидеть "сохранение не удалось"

  Сценарий: Редактирование странички преподавателя
    Допустим я зашел на страничку преподавателя Алексей Никитин
    Если я кликаю на "Править"
    И я ввожу "Лёшка" в поле "Имя"
    И я ввожу "Никитыч" в поле "Фамилия"
    И я нажимаю на "Обновить"
    То я должен видеть "Информация о преподавателе успешно обновлена"

  Сценарий: Редактирование странички преподавателя с ошибками
    Допустим я зашел на страничку преподавателя Алексей Никитин
    Если я кликаю на "Править"
    И я ввожу "Лёха" в поле "Имя"
    И я ввожу "Никитин" в поле "Фамилия"
    И я ввожу "не телефон" в поле "Телефон"
    И я нажимаю на "Обновить"
    То я должен увидеть "сохранение не удалось"

  Сценарий: Удаление странички преподавателя
    Допустим я зашел на страничку преподавателя Алексей Никитин
    Если я кликаю на "Править"
    И я нажимаю на "Удалить"
    То я должен увидеть "Информация о преподавателе удалена"