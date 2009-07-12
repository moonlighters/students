Допустим /^у меня есть преподаватель (.*) (\w*)$/ do |name, surname|
  Factory :teacher, :name => name, :surname => surname
end

Допустим /^у меня есть преподаватель (.*) (.*), доступный по телефону (.*)$/ do |name, surname, phone|
  Factory :teacher, :name => name, :surname => surname, :phone => phone
end
