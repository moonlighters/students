class ForumPostsController < InheritedResources::Base
  
  respond_to :html

  before_filter :set_forum, :only => [:show, :edit, :update, :destroy]
  before_filter :find_forum_post, :only => [:edit, :update, :destroy]

  access_control do
    allow logged_in, :to => [:new, :create]
    actions :edit, :update, :destroy do
      allow :owner, :of => :forum_post
      allow :moderator, :of => :forum
    end
  end

  actions :all, :except => [:index, :show]

  def new
    parent_topic = ForumTopic.find params[:id]
    build_resource
    resource.topic = parent_topic
    find_last_posts

    new!
  end

  def create
    build_resource
    resource.owner = current_user
    find_last_posts

    create! do |success, failure|
      success.html { redirect_to smart_post_path( resource ) }
    end
  end

  def update
    resource.last_editor = current_user
    update! do |success, failure|
      success.html { redirect_to smart_post_path( resource ) }
    end
  end

  def destroy
    topic = resource.topic
    destroy! { forum_topic_path( topic ) }
  end

  private
    def find_forum_post
      resource
    end
    def find_last_posts
      @last_forum_posts = ForumPost.find_all_by_forum_topic_id  resource.topic.id,
                                                                :order => "id DESC",
                                                                :limit => 10
    end
    def set_forum
      @forum = resource.topic.forum
    end
end
