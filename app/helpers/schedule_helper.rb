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
