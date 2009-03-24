class ForumPost < ActiveRecord::Base
  validates_presence_of :body, :user_id, :forum_topic_id

  belongs_to  :topic,
              :foreign_key => "forum_topic_id",
              :class_name => "ForumTopic"
  belongs_to  :user
end
