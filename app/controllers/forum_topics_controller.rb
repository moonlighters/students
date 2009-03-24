class ForumTopicsController < ApplicationController

  before_filter :find_forum_topic, :only => [:show, :edit, :update, :destroy]

  # GET /forums/topics/1
  def show
    @forum_posts = @forum_topic.posts
    @forum_topic.view!
  end

  # GET /forums/1/new_topic
  def new
    @forum_topic = ForumTopic.new
    @forum_topic.forum = Forum.find params[:id]
  end

  # GET /forums/topics/1/edit
  def edit
  end

  # POST /forums/topics
  def create
    @forum_topic = ForumTopic.new params[:forum_topic]
    @forum_topic.user = current_user

    if @forum_topic.save
      flash[:notice] = 'Тема была успешно создана.'
      redirect_to forum_topic_path( @forum_topic )
    else
      render :action => "new"
    end
  end

  # PUT /forums/topics/1
  def update
    if @forum_topic.update_attributes params[:forum_topic]
      flash[:notice] = 'Тема была успешно обновлена.'
      redirect_to forum_topic_path( @forum_topic )
    else
      render :action => "edit"
    end
  end

  # DELETE /forums/topics/1
  def destroy
    forum = @forum_topic.forum
    @forum_topic.destroy

    redirect_to forum_path( forum )
  end

  private
    def find_forum_topic
      @forum_topic = ForumTopic.find params[:id]
    end
end
