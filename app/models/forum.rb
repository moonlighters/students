class Forum < ActiveRecord::Base
  validates_presence_of :title, :description

  acts_as_tree

  has_many  :topics,
            :class_name => "ForumTopic",
            :dependent => :destroy
  def path
    f = self
    path = [self]

    while f = f.parent
      path.unshift parent
    end
    path
  end
end
