class User < ActiveRecord::Base
  acts_as_authentic :login_field => "login"

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
end
