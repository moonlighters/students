require 'date'

module ScheduleHelper
  include ApplicationHelper
  
  def link_to_day_schedule(date=nil, group=nil, options = {})
    actual_date = date || Time.now
    content = options.delete(:content) || format_time( actual_date, :time => false )
    prefix = options.delete(:prefix) || ""
    suffix = options.delete(:suffix) || ""
    content = prefix + content + suffix
    url = date ? day_schedule_path( format_time( date, :format => :ansi, :time => false ) ) : today_schedule_path
    url += "?group_id=#{group.id}" if group
    link_to h( content ), url, options
  end

  def term(date, start_year)
    raise ArgumentError, "given date is earlier then studying start date" if date.year < start_year or
                                                                            (date.year == start_year and date.month <= 8)
    if date.month >= 9
      (date.year - start_year)*2 + 1   # September to December - 1, 3, 5, ...
    elsif date.month == 1
      (date.year - start_year)*2 - 1   # January - 1, 3, 5, ...
    else
      (date.year - start_year)*2   # February to August - 2, 4, 6, ...
    end
  end

  def odd_week?(date)
    today = Date.new date.year, date.month, date.day

    term_starts = (0..1).map do |i|
      date = Date.new( * [today.year] + Lesson::START_DATES[i] ) 
      date += 1 if date.cwday == 7
      date
    end

    term =  (today > term_starts[0] and today < term_starts[1]) ? 0 : 1
    
    (today.cweek - term_starts[term].cweek + 1) % 2 == 1
  end

  def lessons_column(collection)
  # draws rectangles for lessons, putting the HTML returned by block into them
    html = ""
    collection.each_with_index do |item, i|
      height = (item.end_time - item.start_time)/Lesson::SECONDS_PER_PIXEL
      margin_top = ( i == 0 ?  ( item.start_time - Lesson::BEGIN_TIME_OBJ ) :
                                  (item.start_time - collection[i-1].end_time) ) / Lesson::SECONDS_PER_PIXEL
      div_style = "height: #{height - 2}px; margin-top: #{margin_top}px;"
      html += content_tag( :div, :class => "lesson-div", :style => div_style ) do
        content_tag :table do
          content_tag :td do
            block_given? ? yield( item, i ) : ""
          end
        end
      end
    end
    html
  end
end
