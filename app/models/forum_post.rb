class ForumPost < ActiveRecord::Base
  
  acts_as_authorization_object

  acts_as_ownable

  validates_presence_of :body, :forum_topic_id
  validates_presence_of :owner
  validates_presence_of :last_editor_id,
                        :on => :update,
                        :if => Proc.new { |p| p.saving_editor_on_update? }

  belongs_to  :topic,
              :foreign_key => "forum_topic_id",
              :class_name => "ForumTopic"
  belongs_to  :last_editor,
              :class_name => "User"

  cattr_reader :per_page
  @@per_page = 10
  
  # call #not_saving_editor_on_update! if you want to #save and don't want to set last_editor
  # (if you want the post to look like it wasn't edited at all)
  def not_saving_editor_on_update!
    @not_saving_editor_on_update = true
  end
  def saving_editor_on_update!
    @not_saving_editor_on_update = false
  end
  def saving_editor_on_update?
    not @not_saving_editor_on_update
  end
end
