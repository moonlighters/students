class DiscussionsController < InheritedResources::Base

  before_filter :find_discussion, :only => [:edit, :update, :destroy]
  
  access_control do
    allow logged_in
    allow :owner, :of => :discussion, :to => [:edit, :update, :destroy]
  end

  def index
    build_resource
    @discussions = Discussion.all :order => "created_at DESC"
    index!
  end

  def create
    build_resource
    resource.owner = current_user
    create! do |success, failure|
      success.html { redirect_to :action => :index }
      failure.html { render :action => :new }
    end
  end

  private
    def find_discussion; resource; end # FIXME допинать acl9 поддерживать instance_method
end
