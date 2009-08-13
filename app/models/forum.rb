class Forum < ActiveRecord::Base
  
  acts_as_authorization_object

  validates_presence_of :title, :description

  acts_as_tree

  has_many  :topics,
            :class_name => "ForumTopic",
            :dependent => :destroy

  def moderator!(user)
    accepts_role! :moderator, user
    self.children.each do |forum|
      forum.moderator! user
    end
  end
  def not_moderator!(user)
    accepts_no_role! :moderator, user
    self.children.each do |forum|
      forum.not_moderator! user
    end
  end
  def moderator?(user)
    accepts_role? :moderator, user
  end

  def has_unread_posts_of?(user)
    self.topics.each do |topic|
      return true if topic.first_unread_post_of user
    end
    self.children.each do |subforum|
      return true if subforum.has_unread_posts_of? user
    end
    false
  end
end
