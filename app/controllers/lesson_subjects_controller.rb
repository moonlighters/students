class LessonSubjectsController < ApplicationController

  before_filter :find_lesson_subject, :only => [:show, :edit, :update, :destroy]

  # GET /schedule/subjects
  def index
    @terms = LessonSubject.terms
    @lesson_subjects = {}
    @terms.each do |term|
      @lesson_subjects[term] = LessonSubject.find_all_by_term term, :order => "name"
    end

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /schedule/subjects/1
  def show
    @lesson_subject_types = LessonSubjectType.find  :all,
                                                    :order => "group_id, lesson_type_id",
                                                    :conditions => ["lesson_subject_id = ?", @lesson_subject]
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
    set_short_name

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
    @lesson_subject.attributes = params[:lesson_subject]
    set_short_name
    respond_to do |format|
      if @lesson_subject.save 
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

    def set_short_name
      @lesson_subject.short_name = @lesson_subject.name if @lesson_subject.short_name.blank?
    end
end
