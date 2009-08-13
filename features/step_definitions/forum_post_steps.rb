Допустим /^у меня (?:есть|появилось)( [\d]*)? сообщени(?:е|я|й) "([^\"]*)" в теме (.+)$/ do |count, post, topic_title|
  topic = ForumTopic.find_by_title! topic_title 
  count = (count || "1").to_i
  count.times { Factory :forum_post, :body => post, :topic => topic }
end

Допустим /^у меня (?:есть|появилось) сообщение "([^\"]*)" от пользователя (.+) в теме (.+)$/ do |post, user_login, topic_title|
  owner = User.find_by_login! user_login
  topic = ForumTopic.find_by_title! topic_title 
  Factory :forum_post, :body => post, :topic => topic, :owner => owner
end
