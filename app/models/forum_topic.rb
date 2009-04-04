class ForumTopic < ActiveRecord::Base
  validates_presence_of :title, :user_id, :forum_id

  belongs_to :forum
  belongs_to :user
  
  has_many  :posts,
            :class_name => "ForumPost",
            :dependent => :destroy

  before_create do |topic|
    topic.view_count = 0
  end

  attr_accessor :post

  def view!( user )
    if user
      v = ForumTopicViewing.find_or_initialize_by_user_id_and_forum_topic_id( user.id, self.id )
      v.post = ForumPost.find :first,
                              :conditions => ["forum_topic_id = ?", self.id],
                              :order => "id DESC"
      v.save
    end
    self.view_count += 1
    self.save
  end
end
