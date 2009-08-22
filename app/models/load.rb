class Load < ActiveRecord::Base

  acts_as_authorization_object
  acts_as_ownable

  acts_as_taggable_on :tags
  

  # TODO: hide file with path and url options
  has_attached_file :file

  validates_presence_of :name, :tag_list
  validates_attachment_presence :file, :message => "должен присутствовать"

end
