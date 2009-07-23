module ForumsHelper
  def link_to_forum(forum, options = {})
    caption = options.delete :caption
    if forum
      link_to caption || h(forum.title), forum_path( forum ), options
    else
      link_to caption || "Форумы", forums_path, options
    end
  end

  def forum_path_formatted(forum)
    return link_to_forum( nil ) unless forum
    ([nil] + forum.ancestors.reverse + [forum]).map { |f| link_to_forum f }.join " > "
  end
end
