Допустим /^у меня есть форумы (.+)$/ do |titles|
  titles.split(', ').each do |title|
    Factory :forum, :title => title
  end
end

Допустим /^у меня есть форум ([\w\s]+)(?: \((.+)\))?$/ do |title, desc|
  Factory :forum, :title => title, :description => desc || "о том о сем"
end

Допустим /^у меня есть только форумы (.+)$/ do |titles|
  Forum.delete_all
  Допустим "у меня есть форумы #{titles}"
end

Допустим /^у меня есть только форум ([\w\s]+)(?: \((.+)\))?$/ do |title, desc|
  Forum.delete_all
  Допустим "у меня есть форум #{title}" + (desc ? " (#{desc})" : "")
end
