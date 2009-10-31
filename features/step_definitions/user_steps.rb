def nickname_as (user, pass)
  visit nickname_path
  fill_in "Логин", :with => user 
  fill_in "Пароль", :with => pass
  click_button "Войти"
  response.should contain "Вы вошли на сайт"
end

Допустим /^я залогинился как (.+)$/ do |nickname|
  Допустим "есть пользователь #{nickname} с паролем 123456"
  nickname_as nickname, "123456"
end

Допустим /^я залогинился с ролью (.+) как (.+)$/ do |role, nickname|
  Допустим "есть пользователь #{nickname} с паролем 123456"
  User.find_by_nickname( nickname ).has_role! role
  nickname_as nickname, "123456"
end

Допустим /^я разлогинен$/ do
  visit root_path
  if response.body =~ /выйти/
    click_ "выйти"
    response.should contain "Вы успешно прекратили сеанс работы!"
  end
end

Допустим /^есть пользователь (.+) с паролем (.+)$/ do |nickname, pass|
  Factory :user, :nickname => nickname, :password => pass
end
