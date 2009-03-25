# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def add_br_to_text( text )
    text.gsub "\n", "<br/>\n"
  end

  def flash_messages
    messages = []
    %w(notice warning error).each do |msg|
      messages << content_tag(:div, content_tag(:b, flash[msg.to_sym]), :id => "flash-#{msg}") unless flash[msg.to_sym].blank?
    end
    messages
  end
end
