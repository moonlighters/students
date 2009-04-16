class ForumPost < ActiveRecord::Base
  validates_presence_of :body, :user_id, :forum_topic_id
  validates_presence_of :last_editor_id, :on => :update

  belongs_to  :topic,
              :foreign_key => "forum_topic_id",
              :class_name => "ForumTopic"
  belongs_to  :user
  belongs_to  :last_editor,
              :class_name => "User"

  cattr_reader :per_page
  @@per_page = 10

end
