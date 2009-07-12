class GroupsController < ApplicationController

  before_filter :find_group, :only => [:show, :edit, :update, :destroy]
  
  # GET /groups
  def index
    @groups = Group.find  :all, 
                          :order => "name, start_year"

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /groups/1
  def show

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /groups/new
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  def create
    @group = Group.new params[:group]

    respond_to do |format|
      if @group.save
        flash[:notice] = 'Группа успешно добавлена.'
        format.html { redirect_to group_path(@group) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /groups/1
  def update
    respond_to do |format|
      if @group.update_attributes params[:group]
        flash[:notice] = 'Группа успешно обновлена.'
        format.html { redirect_to group_path(@group) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /groups/1
  def destroy
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_path }
      flash[:notice] = 'Группа удалена.'
    end
  end

  private
    def find_group
      @group = Group.find params[:id]
    end
end
