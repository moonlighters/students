Допустим /^я залогинился как (.+)$/ do |login|
  Допустим "есть пользователь #{login} с паролем 123456"
  visit login_path
  fill_in "Логин", :with => login
  fill_in "Пароль", :with => "123456"
  click_button "Войти"
  response.should contain "Вы вошли на сайт"
end

Допустим /^я залогинился с ролью (.+) как (.+)$/ do |role, login|
  Допустим "есть пользователь #{login} с паролем 123456"
  User.find_by_login( login ).has_role! role
  visit login_path
  fill_in "Логин", :with => login
  fill_in "Пароль", :with => "123456"
  click_button "Войти"
  response.should contain "Вы вошли на сайт"
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
