Функционал: Форум
  Чтобы пользователи могли общаться
  Создается древовидная сеть форумов

  Сценарий: Просмотр списка форумов
    Допустим у меня есть форумы Машины, Цветы
    Если я иду на список форумов
    То я должен увидеть "Машины"
    И я должен увидеть "Цветы"
  
  Сценарий: Просмотр форума
    Допустим у меня есть форум Машины (все о тачилах)
    Если я иду на форум Машины
    То я должен видеть "Машины"
    И я должен видеть "Описание: все о тачилах"

  Сценарий: Создание форума
    Допустим я зашел на список форумов
    Если я кликаю на "Новый форум"
    И я ввожу "О молоке" в поле "Название"
    И я ввожу "белое такое" в поле "Описание"
    И я нажимаю на "Создать"
    То я должен быть на форуме О молоке
    И я должен увидеть "Форум успешно создан"

  Сценарий: Создание подфорума в форуме
    Допустим у меня есть только форум Магазин
    И я зашел на форум Магазин
    Если я кликаю на "Новый форум"
    И я ввожу "О молоке" в поле "Название"
    И я ввожу "белое такое" в поле "Описание"
    И я нажимаю на "Создать"
    То я должен быть на форуме О молоке
    И я должен увидеть "Форум успешно создан"

  Сценарий: Создание форума в ошибками
    Допустим я зашел на список форумов
    Если я кликаю на "Новый форум"
    И я ввожу "О молоке" в поле "Название"
    И я ввожу "" в поле "Описание"
    И я нажимаю на "Создать"
    То я должен быть на создании форума
    И я должен увидеть "сохранение не удалось"
  
  Сценарий: Редактирование форума
    Допустим у меня есть только форум О молоке (белое такое)
    И я зашел на форум О молоке
    Если я кликаю на "Править"
    И я ввожу "О теплом молоке" в поле "Название"
    И я ввожу "такое противное" в поле "Описание"
    И я нажимаю на "Обновить"
    То я должен быть на форуме О теплом молоке
    И я должен увидеть "Форум успешно обновлен"

  Сценарий: Редактирование форума с ошибками
    Допустим у меня есть только форум О молоке (белое такое)
    И я зашел на форум О молоке
    Если я кликаю на "Править"
    И я ввожу "" в поле "Название"
    И я ввожу "такое противное" в поле "Описание"
    И я нажимаю на "Обновить"
    То я должен быть на редактировании форума О молоке
    И я должен увидеть "сохранение не удалось"