Допустим /^у меня есть предмет (.+) в (.+) семестре$/ do |name, term|
  Factory :lesson_subject, :name => name, :term => term.to_i
end
