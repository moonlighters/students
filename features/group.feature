Функционал: Академические группы
  Чтобы иметь возможность общаться в пределах группы
  И составлять расписание для разных групп
  Нужно иметь список групп и уметь управлять им

  Предыстория:
    Допустим у меня есть группа 7371, существующая с 2007 года
    И у меня есть группа 5109, существующая с 1995 года
  
  Сценарий: Просмотр групп
    #TODO: tables in features
    Если я иду в список групп
    То я должен увидеть "7371"
    И я должен увидеть "5109"

  Сценарий: Просмотр группы
    Если я иду в группу 7371
    То я должен увидеть "7371"
    И я должен увидеть "2007"

  Сценарий: Создание группы
    Допустим я зашел в список групп
    Если я кликаю на "Добавить группу"
    И я ввожу "Не АФТИ" в поле "Название"
    И я ввожу "2008" в поле "Год начала обучения"
    И я нажимаю на "Добавить"
    То я должен быть в группе Не АФТИ
    И я должен видеть "Группа успешно добавлена"

  Сценарий: Создание группы с ошибками
    Допустим я зашел в список групп
    Если я кликаю на "Добавить группу"
    И я ввожу "" в поле "Название"
    И я ввожу "1999" в поле "Год начала обучения"
    И я нажимаю на "Добавить"
    То я должен увидеть "сохранение не удалось"

  Сценарий: Редактирование группы
    Допустим я зашел в группу 7371
    Если я кликаю на "Править"
    И я ввожу "8371" в поле "Название"
    И я ввожу "2008" в поле "Год начала обучения"
    И я нажимаю на "Обновить"
    То я должен видеть "Группа успешно обновлена"
    И я должен быть в группе 8371

  Сценарий: Редактирование группы с ошибками
    Допустим я зашел в группу 7371
    Если я кликаю на "Править"
    И я ввожу "8371" в поле "Название"
    И я ввожу "1825" в поле "Год начала обучения"
    И я нажимаю на "Обновить"
    То я должен видеть "сохранение не удалось"

  Сценарий: Удаление группы
    Допустим я зашел в группу 7371
    Если я кликаю на "Править"
    И я нажимаю на "Удалить"
    То я должен увидеть "Группа удалена"

