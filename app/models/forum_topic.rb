class ForumTopic < ActiveRecord::Base
  validates_presence_of :title, :user_id, :forum_id

  belongs_to :forum
  belongs_to :user

  before_create do |topic|
    topic.view_count = 0
  end
end
