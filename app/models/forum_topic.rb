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

  def first_unread_post_of( user )
    if user.nil?
      nil
    else
      last = user.last_forum_posts.of_topic self
      if last.nil?
        nil
      else
        ForumPost.find_by_forum_topic_id self,
                                         :conditions => ["id > ?", last.id],
                                         :order => "id ASC"
      end
    end
  end
end
