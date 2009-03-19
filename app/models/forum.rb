class Forum < ActiveRecord::Base
  validates_presence_of :title, :description

  acts_as_tree

  has_many :forum_topics
end
