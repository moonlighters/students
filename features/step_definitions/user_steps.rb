def login_as(user, pass)
  visit login_path
  fill_in "Ник", :with => user 
  fill_in "Пароль", :with => pass
  click_button "Войти"
  response.should contain "Вы вошли на сайт"
end

Допустим /^я залогинился как (.+)$/ do |nickname|
  Допустим "есть пользователь #{nickname} с паролем 123456"
  login_as nickname, "123456"
end

Допустим /^я залогинился с ролью (.+) как (.+)$/ do |role, nickname|
  Допустим "есть пользователь #{nickname} с паролем 123456"
  User.find_by_nickname( nickname ).has_role! role
  login_as nickname, "123456"
end

Допустим /^я разлогинен$/ do
  visit root_path
  if response.body =~ /выйти/
    click_button "выйти"
    response.should contain "Вы успешно прекратили сеанс работы!"
  end
end

Допустим /^есть пользователь (.+) с паролем (.+)$/ do |nickname, pass|
  Factory :user, :nickname => nickname, :password => pass
end
