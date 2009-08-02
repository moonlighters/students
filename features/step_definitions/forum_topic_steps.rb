Допустим /^у меня есть тема (.+) на форуме (.+) c описанием "([^\"]*)" и сообщением "([^\"]*)"$/ do |title, forum_title, desc, post|
  topic = Factory :forum_topic, :title => title, :description => desc, :forum_id => Forum.find_by_title!( forum_title ).id
  Factory :forum_post, :body => post, :topic => topic
end

Допустим /^у меня есть тема (.+) на форуме (.+) c описанием "([^\"]*)" и сообщением "([^\"]*)", созданная пользователем (.+)$/ do |title, forum_title, desc, post, user|
  topic = Factory :forum_topic,
                  :title => title,
                  :description => desc,
                  :forum => Forum.find_by_title!( forum_title ),
                  :owner => User.find_by_login!( user )
  Factory :forum_post, :body => post, :topic => topic
end


