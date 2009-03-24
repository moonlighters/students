class ForumTopic < ActiveRecord::Base
  validates_presence_of :title, :user_id, :forum_id

  belongs_to :forum
  belongs_to :user
  
  has_many  :posts,
            :class_name => "ForumPost"

  before_create do |topic|
    topic.view_count = 0
  end

  def view!
    self.view_count += 1
    self.save
  end
end
