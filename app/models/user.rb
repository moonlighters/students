class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field = "login"
    c.validates_uniqueness_of_login_field_options :case_sensitive => true
  end

  acts_as_authorization_subject

  attr_protected :login

  has_many  :forum_topics
  has_many  :forum_posts
  has_many  :forum_topic_viewings
  has_many  :last_forum_posts,
            :through => :forum_topic_viewings,
            :source => :post do
              def of_topic( topic )
                find_by_forum_topic_id topic.id
              end
            end
  belongs_to :sex

  validates_presence_of :sex

  def male?; sex.name == "мужской"; end
  def female?; sex.name == "женский"; end
  def undefined?; sex.name == "не определился"; end
end
