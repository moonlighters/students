Функционал: Загрузки
  Чтобы пользователи могли скачивать полезные файлы
  Их загружают модераторы загрузок

  Сценарий: Просмотр списка загрузок не модератором
    Допустим у меня есть загрузка Месы (Бла-бла-бла)
    И у меня есть загрузка Домашка ()
    Если я иду на список загрузок
    То я должен увидеть "Месы"
    И я должен увидеть "Домашка"
    И я не должен увидеть "Добавить"

  Сценарий: Просмотр загрузки залогиненым
    Допустим у меня есть загрузка Домашка (Номера 2 и 3)
    И я залогинился как Вася
    Если я иду на список загрузок
    И я кликаю на "Домашка"
    То я должен увидеть "Домашка"
    И я должен увидеть "Номера 2 и 3"
    И я должен увидеть "Скачать"

  Сценарий: Добавление загрузки модератором
    Допустим я залогинился с ролью upload_moderator как Вася
    Если я иду на список загрузок
    И я кликаю на "Добавить"
    И я ввожу "Домашка" в поле "Имя"
    И я ввожу "Номер 2 и 3" в поле "Описание"
    И я прикрепляю файл "Rakefile" к "Файл"
    И я ввожу "homework, math23" в поле "Теги"
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

  Сценарий: Выборка по тегу
    Допустим у меня есть загрузка Домашка1 с тегами "one"
    И у меня есть загрузка Домашка12 с тегами "one, two"
    И у меня есть загрузка Домашка13 с тегами "one, three"
    И у меня есть загрузка Домашка23 с тегами "two, three"
    Если я иду на список загрузок
    И я кликаю на "Домашка1"
    И я кликаю на "one"
    То я должен увидеть "Домашка1"
    И я должен увидеть "Домашка13"
    И я должен увидеть "Домашка12"

  Сценарий: Выборка по двум тегам
    Допустим у меня есть загрузка Домашка1 с тегами "one"
    И у меня есть загрузка Домашка2 с тегами "one, two, three"
    И у меня есть загрузка Домашка3 с тегами "one, three, four"
    И у меня есть загрузка Домашка4 с тегами "one, two, three, four"
    Если я иду на список загрузок
    И я кликаю на "two"
    И я кликаю на "add-tag-link-three"
    То я должен увидеть "Домашка2"
    И я должен увидеть "Домашка4"

  Сценарий: Выборка с удалением тега
    Допустим у меня есть загрузка Домашка1 с тегами "one"
    И у меня есть загрузка Домашка2 с тегами "one, two, three"
    И у меня есть загрузка Домашка3 с тегами "one, three, four"
    И у меня есть загрузка Домашка4 с тегами "one, two, three, four"
    Если я иду на список загрузок
    И я кликаю на "two"
    И я кликаю на "add-tag-link-three"
    И я кликаю на "remove-tag-link-two"
    То я должен увидеть "Домашка2"
    И я должен увидеть "Домашка3"
    И я должен увидеть "Домашка4"

  Сценарий: Выборка с удалением последнего тега
    Допустим у меня есть загрузка Домашка1 с тегами "one"
    И у меня есть загрузка Домашка2 с тегами "one, two, three"
    Если я иду на список загрузок
    И я кликаю на "two"
    И я кликаю на "remove-tag-link-two"
    То я должен увидеть "Домашка1"
    И я должен увидеть "Домашка2"


# TODO: можно ли это как-либо оттестировать??
  Сценарий: Попытка добавить файл не модератором
  Сценарий: Попытка скачать разлогиненым
  Сценарий: Попытка редактирования не владельцем
  Сценарий: Попытка удаления не владельцем
