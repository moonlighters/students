def login_as (user, pass)
  visit login_path
  fill_in "Логин", :with => user 
  fill_in "Пароль", :with => pass
  click_button "Войти"
  response.should contain "Вы вошли на сайт"
end

Допустим /^я залогинился как (.+)$/ do |login|
  Допустим "есть пользователь #{login} с паролем 123456"
  login_as login, "123456"
end

Допустим /^я залогинился с ролью (.+) как (.+)$/ do |role, login|
  Допустим "есть пользователь #{login} с паролем 123456"
  User.find_by_login( login ).has_role! role
  login_as login, "123456"
end

Допустим /^я залогинился, будучи модератором на форуме (.+), как (.+)$/ do |forum, login|
  Допустим "есть пользователь #{login} с паролем 123456"
  Forum.find_by_title!( forum ).moderator! User.find_by_login( login )
  login_as login, "123456"
end

Допустим /^я разлогинен$/ do
  visit root_path
  if response.body =~ /выйти/
    click_ "выйти"
    response.should contain "Вы успешно прекратили сеанс работы!"
  end
end

Допустим /^есть пользователь (.+) с паролем (.+)$/ do |login, pass|
  Factory :user, :login => login, :password => pass
end
