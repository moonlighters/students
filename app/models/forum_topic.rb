class ForumTopic < ActiveRecord::Base

  acts_as_authorization_object

  validates_presence_of :title, :forum_id
  validates_presence_of :owner
  
  belongs_to :forum
  
  has_many  :posts,
            :class_name => "ForumPost",
            :dependent => :destroy

  attr_accessor :post

  cattr_reader :per_page
  @@per_page = 10

  # owner accessors

  def owner
    @owner ||
    ( accepted_roles.first.nil? ? nil : accepted_roles.first.users.first )
  end

  def owner=(user)
    @owner = user
  end

  def owner?(u); u == owner; end
  
  # This callback applies changing an owner by adding/removing roles
  def after_save 
    return unless @owner

    unless accepted_roles.first.nil?
      accepted_roles.first.users.each do |user|
        accepts_no_role!( :owner, user ) # unassign previous owners
      end
    end
      
    accepts_role!( :owner, @owner ) # assign new owner
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
    self.view_count += 1
    self.save!
  end

  def first_unread_post_of( user )
    return nil unless user

    last = user.last_forum_posts.of_topic self
    return nil unless last

    ForumPost.find_by_forum_topic_id self,
                                     :conditions => ["id > ?", last.id],
                                     :order => "id"
  end
end
