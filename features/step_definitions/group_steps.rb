Допустим /^у меня есть группа (.+), существующая с (.+) года$/ do |name, start_year|
  Factory :group, :name => name, :start_year => start_year.to_i
end
