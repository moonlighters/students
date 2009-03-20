class ForumTopicsController < ApplicationController

  before_filter :find_topic, :only => [:show, :edit, :update, :destroy]

  # GET /forums/topics/1
  def show
    @topic.view!
  end

  # GET /forums/1/new_topic
  def new
    @topic = ForumTopic.new
    @topic.forum = Forum.find params[:id]
  end

  # GET /forums/topics/1/edit
  def edit
  end

  # POST /forums/topics
  def create
    @topic = ForumTopic.new params[:topic]
    @topic.user = current_user

    if @topic.save
      flash[:notice] = 'Тема была успешно создана.'
      redirect_to topic_path( @topic )
    else
      render :action => "new"
    end
  end

  # PUT /forums/topics/1
  def update
    if @topic.update_attributes params[:topic]
      flash[:notice] = 'Тема была успешно обновлена.'
      redirect_to topic_path( @topic )
    else
      render :action => "edit"
    end
  end

  # DELETE /forums/topics/1
  def destroy
    forum = @topic.forum
    @topic.destroy

    redirect_to forum_path( forum )
  end

  private
    def find_topic
      @topic = ForumTopic.find params[:id]
    end
end
