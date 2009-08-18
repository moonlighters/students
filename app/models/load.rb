class Load < ActiveRecord::Base

  acts_as_authorization_object

  # TODO: hide file with path and url options
  has_attached_file :file

  # TODO: acts_as_taggable

  acts_as_ownable
  
  validates_presence_of :name
  validates_presence_of :owner
  validates_attachment_presence :file, :message => "должен присутствовать"

end
