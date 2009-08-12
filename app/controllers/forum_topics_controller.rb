class ForumTopicsController < InheritedResources::Base

  before_filter :set_forum, :only => [:show, :edit, :update, :destroy]
  before_filter :find_forum_topic, :only => [:edit, :update, :destroy]

  access_control do
    allow all, :to => :show
    allow logged_in, :to => [:new, :create]
    actions :edit, :update, :destroy do
      allow :owner, :of => :forum_topic
      allow :moderator, :of => :forum
    end
  end

  actions :all, :except => :index

# GET /forums/topics/1
  def show
    @forum_posts = ForumPost.paginate_by_forum_topic_id resource.id, :page => params[:page]
    resource.view! current_user

    show!
  end

  # GET /forums/1/new_topic
  def new
    build_resource
    resource.forum = Forum.find params[:id]
  end

  # POST /forums/topics
  def create
    build_resource
    resource.owner = current_user 
    post = ForumPost.new  :body => params[:forum_topic][:post],
                          :owner => current_user,
                          :forum_topic_id => 1
    
    if resource.valid? and post.valid?
      resource.save!
      post.forum_topic_id = resource.id
      post.save!

      create!
    else
      if post.errors[:body]
        resource.errors.add :post, post.errors[:body]
      end
      render :action => "new"
    end
  end

  # DELETE /forums/topics/1
  def destroy
    forum = resource.forum
    
    destroy! { forum_path( forum ) }
  end

  private
    def set_forum
      @forum = resource.forum
    end
    def find_forum_topic
      resource
    end
end
