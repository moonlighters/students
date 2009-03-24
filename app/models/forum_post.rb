class ForumPost < ActiveRecord::Base
  validates_presence_of :body, :user_id, :topic_id

  belongs_to :topic,
             :class_name => "ForumTopic"
  belongs_to :user
end
