Допустим /^у меня есть загрузка (.+) \((.*)\)$/ do |name, description|
  Factory :load, :name => name, :description => description
end

Допустим /^у меня есть загрузка (.+) \((.*)\) с владельцем (.+)$/ do |name, description, login|
  unless u = User.find_by_login( login )
    u = Factory :user, :login => login
  end
  Factory :load, :name => name, :description => description, :owner => u
end

