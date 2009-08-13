Функционал: Загрузки
  Чтобы пользователи могли скачивать полезные файлы
  Их загружают модераторы загрузок

  Сценарий: Просмотр списка загрузок не модератором
    Допустим у меня есть загрузка Месы (Бла-бла-бла)
    И у меня есть загрузка Домашка ()
    Если я иду на список загрузок
    То я должен увидеть "Месы"
    И я должен увидеть "Бла-бла-бла"
    И я должен увидеть "Домашка"
    И я не должен увидеть "Добавить"

  Сценарий: Просмотр загрузки разлогиненым
    Допустим у меня есть загрузка Домашка (Номера 2 и 3)
    И я разлогинен
    Если я иду на список загрузок
    И я кликаю на "Домашка"
    То я должен увидеть "Домашка"
    И я должен увидеть "Номера 2 и 3"
    И я не должен увидеть "Скачать"

  Сценарий: Просмотр загрузки залогиненым
    Допустим у меня есть загрузка Домашка (Номера 2 и 3)
    И я залогинился как Вася
    Если я иду на список загрузок
    И я кликаю на "Домашка"
    То я должен увидеть "Скачать"

# TODO: как файл добавить??
  Сценарий: Добавление загрузки модератором
    Допустим я залогинился с ролью upload_moderator как Вася
    Если я иду на список загрузок
    И я кликаю на "Добавить"
    И я ввожу "Домашка" в поле "Имя"
    И я ввожу "Номер 2 и 3" в поле "Описание"
    И я прикрепляю файл "Rakefile" к "Файл"
    И я нажимаю на "Создать Загрузка"
    То я должен увидеть "Загрузка успешно создана"
    
  Сценарий: Редактирование загрузки владельцем
    Допустим я залогинился как Вася
    И у меня есть загрузка Домашка (Номера 2 и 3) с владельцем Вася
    И я зашел на загрузку Домашка
    Если я кликаю на "Редактировать"
    И я ввожу "Домашка для списывания" в поле "Имя"
    И я нажимаю на "Сохранить Загрузка"
    То я должен увидеть "Домашка для списывания"
    И я должен увидеть "Загрузка успешно обновлена"

  Сценарий: Удаление загрузки владельцем
    Допустим я залогинился как Вася
    И у меня есть загрузка Домашка (Номера 2 и 3) с владельцем Вася
    И я зашел на загрузку Домашка
    Если я кликаю на "Редактировать"
    И я кликаю на "Удалить"
    То я должен увидеть "Загрузка успешно удалена"

# TODO: можно ли это как-либо оттестировать??
  Сценарий: Попытка добавить файл не модератором
  Сценарий: Попытка скачать разлогиненым
  Сценарий: Попытка редактирования не владельцем
  Сценарий: Попытка удаления не владельцем
