Допустим /^у меня есть загрузка (.+) \((.*)\)$/ do |name, description|
  Factory :load, :name => name, :description => description
end

Допустим /^у меня есть загрузка (.+) с тегами "([^\"]*)"$/ do |name, tags|
  Factory :load, :name => name, :tag_list => tags
end

Допустим /^у меня есть загрузка (.+) \((.*)\) с владельцем (.+)$/ do |name, description, nickname|
  unless u = User.find_by_nickname( nickname )
    u = Factory :user, :nickname => nickname
  end
  Factory :load, :name => name, :description => description, :owner => u
end

