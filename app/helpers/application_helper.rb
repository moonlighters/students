# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def add_br_to_text(text)
    text.gsub "\n", "<br/>\n"
  end

  def flash_messages
    messages = []
    %w(notice warning error).each do |msg|
      messages << content_tag(:div, content_tag(:b, flash[msg.to_sym]), :id => "flash-#{msg}") unless flash[msg.to_sym].blank?
    end
    messages
  end

  def format_time(time, options={})
    # set default values for :date and :time options
    [:date, :time].each {|param| options[param] = true unless options.include? param }
    # check if either time or date will be shown
    raise ArgumentError, "Invalid format_time options" if not options[:time] and not options[:date]

    month_format = options[:month] == :digits ? ".%m." : " %B "
    time_format = options[:time] ? "%H:%M" : ""
    if options[:date]
      date_format = options[:format] == :ansi ? "%Y-%m-%d" : "%d#{month_format}%Y"
    else
      date_format = ""
    end
    if options[:format] == :ansi
      format = ( options[:time] and options[:date] ) ? date_format + " " + time_format : date_format + time_format
    else
      format = ( options[:time] and options[:date] ) ? time_format + ", " + date_format : time_format + date_format
    end
    Russian::strftime time, format
  end

  def day_of_week(wday)
    Russian::strftime Time.utc(1970, 1, 4) + wday.days, "%A"
  end

  def gender(user, male, female)
    user.female? ? female : male
  end

  def russian_downcase(str)
    str.downcase.tr "А-Я", "а-я"
  end
end
