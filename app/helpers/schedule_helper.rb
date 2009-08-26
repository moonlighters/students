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
end
