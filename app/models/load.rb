class Load < ActiveRecord::Base

  acts_as_authorization_object
  acts_as_ownable

  acts_as_taggable_on :tags
  

  # TODO: hide file with path and url options
  has_attached_file :file

  validates_presence_of :name, :owner
  validates_presence_of :tag_list, :message => "должны присутствовать"
  validates_attachment_presence :file, :message => "должен присутствовать"

  def before_destroy
    # TODO: optimize?
    Tag.all.find_all {|t| t.tagging_ids.count == 0 }.each {|t| t.destroy }
  end

end
