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

  def format_time(datetime, options={})
    date = options[:date] != false
    year = options[:year] != false
    time = options[:time] != false
    ansi = options[:format] == :ansi
    digit_month = options[:month] == :digits

    raise ArgumentError, "Invalid format_time options" unless date or time

    time_format = ( "%H:%M" if time )

    date_format = if date
      if ansi
        "%Y-%m-%d"
      else
        [ "%e",
          digit_month ? "%m" : "%B",
          ( "%Y" if year )
        ].select {|x| !x.nil?}.join( digit_month ? "." : " ")
      end
    end

    format = if ansi
      [date_format, time_format].select {|x| !x.nil?}.join " "
    else
      [time_format, date_format].select {|x| !x.nil?}.join ", "
    end

    Russian::strftime datetime, format
  end

  # A wrapper:
  def ansi_date(time)
    format_time time, :time => false, :format => :ansi
  end

  def day_of_week(wday)
    Russian::strftime Time.utc(1970, 1, 4) + wday.days, "%A"
  end
end
