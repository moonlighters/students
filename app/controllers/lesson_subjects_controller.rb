class LessonSubjectsController < ApplicationController

  before_filter :find_lesson_subject, :only => [:show, :edit, :update, :destroy]

  # GET /schedule/subjects
  def index
    @lesson_subjects = LessonSubject.find :all,
                                          :order => "name, term"

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /schedule/subjects/1
  def show
    @lesson_subject_types = LessonSubjectType.find  :all,
                                                    :order => "group_id, lesson_type_id",
                                                    :conditions => ["lesson_subject_id = ?", @lesson_subject.id]
    #@lesson_subject_types = @lesson_subject.subject_types
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /schedule/subjects/new
  def new
    @lesson_subject = LessonSubject.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /schedule/subjects/1/edit
  def edit
  end

  # POST /schedule/subjects
  def create
    @lesson_subject = LessonSubject.new params[:lesson_subject]

    respond_to do |format|
      if @lesson_subject.save
        flash[:notice] = 'Предмет успешно добавлен.'
        format.html { redirect_to lesson_subject_path( @lesson_subject ) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /schedule/subjects/1
  def update
    respond_to do |format|
      if @lesson_subject.update_attributes params[:lesson_subject]
        flash[:notice] = 'Предмет успешно обновлен.'
        format.html { redirect_to lesson_subject_path( @lesson_subject ) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /schedule/subjects/1
  def destroy
    @lesson_subject.destroy

    flash[:notice] = 'Предмет удален'
    respond_to do |format|
      format.html { redirect_to lesson_subjects_path }
    end
  end

  private
    def find_lesson_subject
      @lesson_subject = LessonSubject.find params[:id]
    end
end
