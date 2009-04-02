Допустим /^у меня есть форумы (.+)$/ do |forums|
  forums.split(', ').each do |name|
    Factory :forum, :title => name
  end
end
