class User < ActiveRecord::Base
  acts_as_authentic :login_field => "login"

  acts_as_authorization_subject

  attr_protected :login

  has_many :forum_topics
end
