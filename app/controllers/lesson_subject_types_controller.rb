class LessonSubjectTypesController < ApplicationController

  before_filter :find_lesson_subject_type, :only => [:show, :edit, :update, :destroy]

#  # GET /schedule/subject_types
#  def index
#    @lesson_subject_types = LessonSubjectType.find :all
#
#    respond_to do |format|
#      format.html # index.html.erb
#    end
#  end

  # GET /schedule/subject_types/1
  def show
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /schedule/subject_types/new
  def new
    @lesson_subject_type = LessonSubjectType.new
    @lesson_subject_type.lesson_type = LessonType.first
    @lesson_subject_type.subject = LessonSubject.find params[:id]
    @lesson_subject_type.homepage = "http://"

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /schedule/subject_types/1/edit
  def edit
  end

  # POST /schedule/subject_types
  def create
    @lesson_subject_type = LessonSubjectType.new params[:lesson_subject_type]

    respond_to do |format|
      if @lesson_subject_type.save
        flash[:notice] = 'Предмет успешно добавлен.'
        format.html { redirect_to lesson_subject_type_path( @lesson_subject_type ) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /schedule/subject_types/1
  def update
    respond_to do |format|
      if @lesson_subject_type.update_attributes params[:lesson_subject_type]
        flash[:notice] = 'Предмет успешно обновлен.'
        format.html { redirect_to lesson_subject_type_path( @lesson_subject_type ) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /schedule/subject_types/1
  def destroy
    @lesson_subject_type.destroy

    flash[:notice] = 'Предмет удален'
    respond_to do |format|
      format.html { redirect_to lesson_subject_types_path }
    end
  end

  private
    def find_lesson_subject_type
      @lesson_subject_type = LessonSubjectType.find params[:id]
    end
end
