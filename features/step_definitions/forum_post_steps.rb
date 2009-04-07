Допустим /^у меня (?:есть|появилось) сообщение "([^\"]*)" в теме (.+)$/ do |post, topic_title|
  topic = ForumTopic.find_by_title( topic_title )
  Factory :forum_post, :body => post, :topic => topic
end
