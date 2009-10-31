class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field = "nickname"
    c.validates_uniqueness_of_login_field_options :case_sensitive => true
  end

  acts_as_authorization_subject

  attr_protected :nickname

  belongs_to :group
end
