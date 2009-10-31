require 'parsedate'

class ScheduleController < ApplicationController
  include ApplicationHelper # NOTE: just for format_date function... Maybe place this function it somwhere else?
  before_filter :set_collections, :only => :choose

  # Exception classes
  class BadDateError < StandardError
  end
  class EarlierThenFirstTermError < StandardError
  end
  class NoGroupError < StandardError
  end

  # GET /schedule/
  def index
    if current_user_group
      respond_to do |format|
        format.html { redirect_to today_schedule_path }
      end
    else
      respond_to do |format|
        format.html { redirect_to choose_schedule_path }
      end
    end
  end

  # GET /schedule/day/2009-08-20
  def day
    apply_params  # it mustn't be a before filter to handle errors correctly

    @term = Lesson.term( @day, @group.start_year ) rescue raise( EarlierThenFirstTermError )
    
    @lessons = Lesson.lessons_for @group, @term, @day.wday, Lesson.odd_week?( @day )
    
    @no_day_schedule = @lessons.nil?
    respond_to do |format|
      format.html # day.html.erb
    end
  rescue BadDateError
    respond_to do |format|
      flash[:error] = "Неверная дата: \"#{params[:date]}\""
      redirect_to_chooser format
    end
  rescue EarlierThenFirstTermError
    respond_to do |format|
      flash[:error] = "Выбранная дата " +
                      format_time(@day, :time => false, :month => :digits) +
                      " раньше начала занятий группы " +
                      @group.name +
                      " (" +
                      "1.09.#{@group.start_year})"
      redirect_to_chooser format
    end
  rescue NoGroupError
    respond_to do |format|
      flash[:error] = "Группа не была указана"
      redirect_to_chooser format
    end
  end


  def week
    apply_params  # it mustn't be a before filter to handle errors correctly
    
    @week_start = @day - ( (@day.wday - 1) % 7 ).days
    @week_end = @week_start + 6.days

    @lessons_batches = []
    @terms = []
    begin
      6.downto 0 do |i|
        day = @week_start + i.days
        @terms[i] = Lesson.term( day, @group.start_year ) rescue raise( EarlierThenFirstTermError )
        @lessons_batches[i] = Lesson.lessons_for @group, @terms[i], day.wday, Lesson.odd_week?( day )
      end
    rescue EarlierThenFirstTermError
      # if there are no lessons in array (therefore, an error occured at last week day)
      raise EarlierThenFirstTermError if @lessons_batches.all?( &:nil? )
    end
    
    @no_week_schedule = @lessons_batches.all?( &:nil? )
    respond_to do |format|
      format.html # week.html.erb
    end
  rescue BadDateError
    respond_to do |format|
      flash[:error] = "Неверная дата: \"#{params[:date]}\""
      redirect_to_chooser format
    end
  rescue EarlierThenFirstTermError
    respond_to do |format|
      flash[:error] = "Выбранные даты " +
                      format_time(@week_start, :time => false, :month => :digits) +
                      " - " +
                      format_time(@week_end, :time => false, :month => :digits) +
                      " раньше начала занятий группы " +
                      @group.name +
                      " - " +
                      "1.09.#{@group.start_year}"
      redirect_to_chooser format
    end
  rescue NoGroupError
    respond_to do |format|
      flash[:error] = "Группа не была указана"
      redirect_to_chooser format
    end
  end

  def choose
    apply_params (true)
    @my_group = current_user_group
    respond_to do |format|
      format.html # choose.html.erb
    end
  end

  def apply
    raise "Wrong date param" unless params[:date].is_a?( Hash )

    date =  params[:date][:year] + "-" + params[:date][:month] + "-" + params[:date][:day]

    path = params[:type] == "week" ?
            week_schedule_for_group_path( params[:group_id], date ) :
            day_schedule_for_group_path( params[:group_id], date )

    respond_to do |format|
      format.html{ redirect_to path }
    end
  end
  
  private
    def redirect_to_chooser(format)
      date = @day.nil? ? "" : ansi_date( @day )
      format.html do
        redirect_to choose_schedule_path( :group_id => params[:group_id], :date => date )
      end
    end

    def apply_params(no_raise = false)
      unless params[:date]
        now = Time.now
        @day =  now.hour >= 18 ? now + 1.day : now
      else
        date_params = ParseDate.parsedate params[:date]
        begin
          @day = Time.mktime *date_params
        rescue
          raise( BadDateError ) if not no_raise
        end
      end

      @group = params[:group_id] ?  Group.find_by_id( params[:group_id] ) : current_user_group
      raise NoGroupError if @group.nil? and not no_raise
    end

    def set_collections
      @groups = Group.find :all, :order => "name"
    end
end
