class ForumsController < ApplicationController

  before_filter :find_forum, :only => [:show, :edit, :update, :new_sub, :destroy]

  # GET /forums
  def index
    @forums = Forum.roots

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /forums/1
  def show
    @children = @forum.children

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /forums/new
  def new_root
    @forum = Forum.new
    @forum.parent = nil

    respond_to do |format|
      format.html { render "new.html.erb" }
    end
  end

  # GET /forums/1/new
  def new_sub
    # set found forum to parent and create new
    parent = @forum
    @forum = Forum.new
    @forum.parent = parent

    respond_to do |format|
      format.html { render "new.html.erb" }
    end
  end

  # GET /forums/1/edit
  def edit
  end

  # POST /forums
  def create
    @forum = Forum.new params[:forum]

    respond_to do |format|
      if @forum.save
        flash[:notice] = 'Forum was successfully created.'
        format.html { redirect_to @forum }
      else
        format.html { render "new" }
      end
    end
  end

  # PUT /forums/1
  def update
    respond_to do |format|
      if @forum.update_attributes(params[:forum])
        flash[:notice] = 'Форум был успешно обновлен.'
        format.html { redirect_to(@forum) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /forums/1
  def destroy
    parent = @forum.parent
    @forum.destroy

    respond_to do |format|
      format.html { redirect_to parent ? forum_path( parent ) : forums_path }
    end
  end

  private
    def find_forum
      @forum = Forum.find params[:id]
    end
end
