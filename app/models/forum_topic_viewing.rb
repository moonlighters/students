class ForumTopicViewing < ActiveRecord::Base
  validates_presence_of :user_id, :forum_topic_id, :forum_post_id

  belongs_to  :user
  belongs_to  :topic,
              :foreign_key => "forum_topic_id",
              :class_name => "ForumTopic"
  belongs_to  :post,
              :foreign_key => "forum_post_id",
              :class_name => "ForumPost"
end
