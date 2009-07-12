class TeachersController < ApplicationController

  before_filter :find_teacher, :only => [:show, :edit, :update, :destroy]
  
  # GET /teachers
  def index
    @teachers = Teacher.find  :all, 
                              :order => "surname, name"

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /teachers/1
  def show

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /teachers/new
  def new
    @teacher = Teacher.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /teachers/1/edit
  def edit
  end

  # POST /teachers
  def create
    @teacher = Teacher.new params[:teacher]

    respond_to do |format|
      if @teacher.save
        flash[:notice] = "Преподаватель успешно добавлен."
        format.html { redirect_to teacher_path(@teacher) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /teachers/1
  def update
    respond_to do |format|
      if @teacher.update_attributes params[:teacher]
        flash[:notice] = "Информация о преподавателе успешно обновлена."
        format.html { redirect_to teacher_path(@teacher) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /teachers/1
  def destroy
    @teacher.destroy

    respond_to do |format|
      format.html { redirect_to teachers_path }
      flash[:notice] = 'Информация о преподавателе удалена.'
    end
  end

  private
    def find_teacher
      @teacher = Teacher.find params[:id]
    end
end
