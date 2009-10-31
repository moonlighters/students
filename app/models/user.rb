class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field = "login"
    c.validates_uniqueness_of_login_field_options :case_sensitive => true
  end

  acts_as_authorization_subject

  attr_protected :login

  belongs_to :sex
  belongs_to :group

  validates_presence_of :sex

  def male?; sex.name == "мужской"; end
  def female?; sex.name == "женский"; end
  def undefined?; sex.name == "не определился"; end
end
