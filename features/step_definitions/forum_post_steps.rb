Допустим /^у меня (?:есть|появилось)( [\d]*)? сообщени(?:е|я|й) "([^\"]*)" в теме (.+)$/ do |count, post, topic_title|
  topic = ForumTopic.find_by_title( topic_title )
  count = (count || "1").to_i
  count.times { Factory :forum_post, :body => post, :topic => topic }
end
