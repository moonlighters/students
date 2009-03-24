# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def add_br_to_text( text )
    text.gsub "\n", "<br/>\n"
  end
end
