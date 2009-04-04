Допустим /^у меня есть тема (.+) на форуме (.+) c описанием "([^\"]*)" и сообщением "([^\"]*)"$/ do |title, forum_title, desc, post|
  topic = Factory :forum_topic, :title => title, :description => desc, :forum_id => Forum.find_by_title( forum_title ).id
  Factory :forum_post, :body => post, :topic => topic
end

