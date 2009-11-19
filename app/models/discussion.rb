class Discussion < ActiveRecord::Base
  acts_as_authorization_object
  acts_as_ownable

  validates_presence_of :message, :owner
end
