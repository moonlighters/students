class Forum < ActiveRecord::Base
  validates_presence_of :title, :description

  acts_as_tree

  has_many  :topics,
            :class_name => "ForumTopic",
            :dependent => :destroy

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
