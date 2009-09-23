require 'parsedate'

class ScheduleController < ApplicationController
  include ApplicationHelper # NOTE: just for format_date function... Maybe place this function it somwhere else?

  # Exception classes
  class BadDateError < StandardError
  end
  class EarlierThenFirstTermError < StandardError
  end
  class NoGroupError < StandardError
  end

  def index
  end

  # GET /schedule/day/2009-08-20
  def day
    unless params[:date]
      now = Time.now
      @day =  now.hour >= 18 ? now + 1.day : now
    else
      date_params = ParseDate.parsedate params[:date]
      @day = Time.mktime( *date_params ) rescue raise( BadDateError )
    end

    @group = params[:group_id] ?  Group.find( params[:group_id] ) : nil # TODO: current_user.group
    raise NoGroupError if @group.nil?

    @term = Lesson.term( @day, @group.start_year ) rescue raise( EarlierThenFirstTermError )
    @lessons = Lesson.lessons_for @group, @term, @day.wday, Lesson.odd_week?( @day )
    
    respond_to do |format|
      format.html # day.html.erb
    end
  rescue BadDateError
    respond_to do |format|
      flash[:error] = "Неверная дата: \"#{params[:date]}\""
      reditect_to_chooser format
    end
  rescue EarlierThenFirstTermError
    respond_to do |format|
      flash[:error] = "Выбранная дата " +
                      format_time(@day, :time => false, :month => :digits) +
                      " раньше начала занятий группы " +
                      @group.name +
                      " - " +
                      "1.09.#{@group.start_year}"
      reditect_to_chooser format
    end
  rescue NoGroupError
    respond_to do |format|
      flash[:error] = "Не указана группа. Выберите группу"
      reditect_to_chooser format
    end
  end


  def week
  end

  def choose
    format.html { redirect_to today_schedule_path } # Just redirect until it's not yet implemented
  end
  
  private
    def reditect_to_chooser(format)
      format.html do
        redirect_to choose_schedule_path + "?group_id=#{params[:group_id]}&date=" + format_time(@day, :time => false, :format => :ansi)
      end
    end

end
