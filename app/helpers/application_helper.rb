# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  PAGINATION_PARAMS = {
    :class => "topics_pagination",
    :previous_label => "назад",
    :next_label => "вперед",
    :separator => " - ",
    :inner_window => 2
  }

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

  def format_time(time)
    Russian::strftime time+30, "%H:%M, %d %B %Y"
  end

  def will_paginate_topics(collection)
    will_paginate collection, PAGINATION_PARAMS
  end
end
