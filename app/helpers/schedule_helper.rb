require 'date'

module ScheduleHelper
  include ApplicationHelper

  def week_caption(start_date = nil, format = :short)
    start_date ||= Time.now
    year = (format == :long)
    format_time( start_date, :time => false, :month => :digits, :year => year ) +
      " - " +
      format_time( start_date + 6.days, :time => false, :month => :digits, :year => year )
  end
  
  def link_to_schedule(date=nil, day_or_week=:day, options = {})
    is_it_week = (day_or_week == :week)
    
    content = options.delete(:content)
    if content.blank?
      if date.nil?
        content = is_it_week ? "На эту неделю" : "На ближайший день"
      else
        content = is_it_week ? week_caption( date ) : format_time( date, :time => false, :year => false )
      end
    end
    prefix = options.delete(:prefix) || ""
    suffix = options.delete(:suffix) || ""
    group = options.delete(:group)

    content = prefix + content + suffix
    # TODO: Make it less ugly
    if date
      if group
        route = (is_it_week ? "week" : "day") + "_schedule_for_group_path"
        url = send route, group, ansi_date( date )
      else
        route = (is_it_week ? "week" : "day") + "_schedule_path"
        url = send route, ansi_date( date )
      end
    else
      if group
        route = (is_it_week ? "this_week" : "today") + "_schedule_for_group_path"
        url = send route, group
      else
        route = (is_it_week ? "this_week" : "today") + "_schedule_path"
        url = send route
      end
    end
    link_to h( content ), url, options
  end

  def lessons_column(collection, options = {})
  # draws rectangles for lessons, putting the HTML returned by block into them
    return "" if collection.blank?
    html = ""
    collection.each_with_index do |item, i|
      height = (item.end_time - item.start_time)/Lesson::SECONDS_PER_PIXEL
      margin_top = ( i == 0 ?  ( item.start_time - Lesson::BEGIN_TIME_OBJ ) :
                                  (item.start_time - collection[i-1].end_time) ) / Lesson::SECONDS_PER_PIXEL
      td_class = unless item.type.nil?
        options[:apply_style] ? Russian.translit( item.type.name ) : ""
      end
      div_style = "height: #{height - 2}px; margin-top: #{margin_top}px;"
      html += content_tag( :div, :class => "lesson-div", :style => div_style ) do
        content_tag :table do
          content_tag :td, :class => td_class do
            block_given? ? yield( item, i ) : ""
          end
        end
      end
    end
    concat html
  end
end
