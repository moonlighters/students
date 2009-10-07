require 'date'

module ScheduleHelper
  include ApplicationHelper

  def week_caption(start_date=nil)
    start_date ||= Time.now
    format_time( start_date, :time => false, :month => :digits ) +
      " - " +
      format_time( start_date + 6.days, :time => false, :month => :digits )
  end
  
  def link_to_schedule(date=nil, day_or_week=:day, options = {})
    date ||= Time.now
    is_it_week = (day_or_week == :week)
    
    content = options.delete(:content)
    if content.blank?
      content = is_it_week ? week_caption( date ) : format_time( date, :time => false )
    end
    prefix = options.delete(:prefix) || ""
    suffix = options.delete(:suffix) || ""
    group = options.delete(:group)

    content = prefix + content + suffix
    if group
      url = is_it_week ? 
              week_schedule_for_group_path(group, ansi_date( date ) ) :
              day_schedule_for_group_path(group, ansi_date( date ) )
    else
      url = is_it_week ? 
              week_schedule_path( ansi_date( date ) ) :
              day_schedule_path( ansi_date( date ) )
    end
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
