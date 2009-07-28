class ForumPostsController < ApplicationController

  before_filter :find_forum_post, :only => [:edit, :update, :destroy]

  # GET /forums/topics/1/new_post
  def new
    parent_topic = ForumTopic.find params[:id]
    unless current_user
      flash[:error] = "Необходимо войти на сайт, чтобы отвечать в темы"
      redirect_to forum_topic_path( parent_topic ) 
    else
      @forum_post = ForumPost.new
      @forum_post.topic = parent_topic
      find_last_posts

      respond_to do |format|
        format.html # new.html.erb
      end
    end
  end

  # GET /forums/posts/1/edit
  def edit
    unless current_user
      flash[:error] = "Необходимо войти на сайт, чтобы редактировать сообщения"
      redirect_to forum_topic_path( @forum_post.topic ) 
    end 
  end

  # POST /forums/posts
  def create
    @forum_post = ForumPost.new params[:forum_post]
    @forum_post.user = current_user
    find_last_posts

    respond_to do |format|
      if @forum_post.save
        flash[:notice] = 'Сообщение успешно добавлено.'
        format.html { redirect_to smart_post_path( @forum_post ) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /forums/posts/1
  def update
    @forum_post.last_editor = current_user
    respond_to do |format|
      if @forum_post.update_attributes params[:forum_post]
        flash[:notice] = 'Сообщение успешно обновлено.'
        format.html { redirect_to smart_post_path( @forum_post ) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /forums/posts/1
  def destroy
    topic = @forum_post.topic
    @forum_post.destroy

    respond_to do |format|
      flash[:notice] = 'Сообщение удалено.'
      format.html { redirect_to forum_topic_path( topic ) }
    end
  end

  private
    def find_forum_post
      @forum_post = ForumPost.find params[:id]
    end

    def find_last_posts
      @last_forum_posts = ForumPost.find_all_by_forum_topic_id  @forum_post.topic.id,
                                                                :order => "id DESC",
                                                                :limit => 10
    end
end
