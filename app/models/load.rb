class Load < ActiveRecord::Base

  acts_as_authorization_object

  # TODO: hide file with path and url options
  has_attached_file :file

  # TODO: acts_as_taggable
  
  validates_presence_of :name
  validates_presence_of :owner
  validates_attachment_presence :file, :message => "должен присутствовать"

  def owner
    unless accepted_roles.first.nil?
      accepted_roles.first.users.first
    end
  end

  def owner=(user)
    accepts_role!( :owner, user ) if user
  end

  def owner?(u); u == owner; end
end
