class ForumTopic < ActiveRecord::Base

  acts_as_authorization_object
  
  acts_as_ownable

  validates_presence_of :title, :forum_id
  validates_presence_of :owner
  validates_each :last_post do |topic, attr, value|
    unless value == ForumPost.find_by_forum_topic_id( topic.id, :order => "id DESC" )
      topic.errors.add(attr, "должен ссылаться на последнеее сообщение в теме" )
    end
  end

  belongs_to :forum
  
  has_many  :posts,
            :class_name => "ForumPost",
            :dependent => :destroy

  has_many  :forum_topic_viewings,
            :dependent => :destroy

  belongs_to  :last_post,
              :class_name => "ForumPost"

  attr_accessor :post
  
  cattr_reader :per_page
  @@per_page = 10
 
  # remembering whether topic is being destroyed
  @@destroyed_topics_ids = []

  def destroy
    # Such perversion with overriding this method is needed because
    # #update_last_post is called when ForumPost is destroyed, and 
    # it should know whether the only one post is just being dstroyed 
    # or the parent topic is being destroyed and it mustn't be updated
    @@destroyed_topics_ids << self.id
    super
  end

  def destroyed?
    @@destroyed_topics_ids.include? self.id
  end

  # keeping last_post attribute up-to-date

  before_validation do |topic|
    # Update topic's last_post attribute
    unless topic.destroyed?
      topic.last_post = ForumPost.find_by_forum_topic_id topic.id, :order => "id DESC"
    end
  end

  def update_last_post!
    # This function just invokes saving, and before_validation block really updates last_post
    self.update_attributes!( :last_post => self.last_post ) unless self.destroyed?
  end

  # handling viewing

  before_create do |topic|
    topic.view_count = 0
  end

  def view!( user )
    if user
      v = ForumTopicViewing.find_or_initialize_by_user_id_and_forum_topic_id( user.id, self.id )
      v.post = ForumPost.find :first,
                              :conditions => ["forum_topic_id = ?", self.id],
                              :order => "id DESC"
      v.save
    end
    self.update_attribute :view_count, self.view_count + 1
  end

  def first_unread_post_of( user )
    return nil unless user

    last = user.last_forum_posts.of_topic self
    return ForumPost.find_by_forum_topic_id self, :order => "id" unless last

    ForumPost.find_by_forum_topic_id self,
                                     :conditions => ["id > ?", last.id],
                                     :order => "id"
  end
end
