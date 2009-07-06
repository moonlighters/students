class LessonsController < ApplicationController

  before_filter :find_lesson, :only => [:show, :edit, :update, :destroy]
  
  # GET /schedule/lessons/1
  def show

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /schedule/lessons/new
  def new
    @lesson = Lesson.new
    @lesson.day_of_week = 1
    @lesson.set_start_time 9, 0
    @lesson.duration = 1.hours + 35.minutes
    @lesson.lesson_subject_id = LessonSubject.first.id
    @lesson.lesson_type_id = LessonType.first.id
    @lesson.everyweek = true

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /schedule/lessons/1/edit
  def edit
    @lesson.lesson_subject_id = @lesson.subject_type.subject.id
    @lesson.lesson_type_id = @lesson.subject_type.lesson_type.id
  end

  # POST /schedule/lessons
  def create
    @lesson = Lesson.new params[:lesson]
    apply_fields

    respond_to do |format|
      if @lesson.save
        flash[:notice] = "Занятие успешно добавлено."
        format.html { redirect_to lesson_path(@lesson) }
      else
        set_aux_fields
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /schedule/lessons/1
  def update
    @lesson.attributes = params[:lesson]
    apply_fields
    respond_to do |format|
      if @lesson.save
        flash[:notice] = "Занятие успешно обновлено."
        format.html { redirect_to lesson_path(@lesson) }
      else
        set_aux_fields
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /schedule/lessons/1
  def destroy
    @lesson.destroy

    respond_to do |format|
      format.html { redirect_to schedule_path }
      flash[:notice] = "Занятие удалено."
    end
  end

  private
    def find_lesson
      @lesson = Lesson.find params[:id]
    end

    def apply_fields
      @lesson.duration = params[:duration][:hour].to_i.hours + params[:duration][:minute].to_i.minutes
      @lesson.set_start_time params[:start_time][:hour].to_i, params[:start_time][:minute].to_i
      @lesson.term = LessonSubject.find( @lesson.lesson_subject_id ).term
      @lesson.subject_type = 
        LessonSubjectType.find_by_lesson_subject_id_and_lesson_type_id_and_group_id @lesson.lesson_subject_id,
                                                                                    @lesson.lesson_type_id,
                                                                                    @lesson.group.id
    end
    def set_aux_fields
      @lesson.lesson_subject_id = params[:lesson][:lesson_subject_id].to_i
      @lesson.lesson_type_id = params[:lesson][:lesson_type_id].to_i
    end
end
