class ForumsController < InheritedResources::Base

  respond_to :html

  actions :all, :except => :new

  access_control do
    allow all, :to => [:index, :show]
    allow :administrator
  end

  # GET /forums
  def index
    @forums = Forum.roots

    index!
  end

  # GET /forums/1
  def show
    @children = resource.children
    @forum_topics = ForumTopic.paginate_by_forum_id resource.id, :page => params[:page], :order => "last_post_id DESC"

    show!
  end

  # GET /forums/new
  def new_root
    build_resource
    @forum.parent = nil

    respond_to do |format|
      format.html { render "new.html.erb" }
    end
  end

  # GET /forums/1/new
  def new_sub
    build_resource
    @forum.parent = @parent_forum

    respond_to do |format|
      format.html { render "new.html.erb" }
    end
  end
  
  # DELETE /forums/1
  def destroy
    parent = resource.parent

    destroy! { parent ? forum_path( parent ) : forums_path }
  end
end
