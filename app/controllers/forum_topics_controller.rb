class ForumTopicsController < InheritedResources::Base

  before_filter :set_forum, :only => [:show, :edit, :update, :destroy]

  access_control do
    allow all, :to => :show
    allow logged_in, :to => [:new, :create]
    actions :edit, :update, :destroy do
      allow :owner, :of => :resource
      allow :moderator, :of => :forum
    end
  end

  # GET /forums/topics/1
  def show
    @forum_posts = ForumPost.paginate_by_forum_topic_id resource.id, :page => params[:page]
    resource.view! current_user

    show!
  end

  # GET /forums/1/new_topic
  def new
    @forum_topic = ForumTopic.new
    @forum_topic.forum = Forum.find params[:id]
  end

  # POST /forums/topics
  def create
    build_resource
    resource.owner = current_user 
    post = ForumPost.new  :body => params[:forum_topic][:post],
                          :user_id => (current_user ? current_user.id : nil),
                          :forum_topic_id => 1
    
    if resource.valid? and post.valid?
      resource.save!
      post.forum_topic_id = resource.id
      post.save!

      create!
      flash[:notice] = 'Тема успешно создана.' #TODO: Normal i18n in inherited_resources instead this
    else
      if post.errors[:body]
        resource.errors.add :post, post.errors[:body]
      end
      render :action => "new"
    end
  end

  # PUT /forums/topics/1
  def update
    update!
    flash[:notice] = 'Тема успешно обновлена.' if flash[:notice] #TODO: Normal i18n in inherited_resources instead this
  end

  # DELETE /forums/topics/1
  def destroy
    forum = resource.forum
    
    destroy! { forum_path( forum ) }
    flash[:notice] = 'Тема удалена.' if flash[:notice] #TODO: Normal i18n in inherited_resources instead this
  end

  private
    def set_forum
      @forum = resource.forum
    end
end
