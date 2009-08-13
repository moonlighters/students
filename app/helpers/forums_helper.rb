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

  # TODO: можно ли как-то не дублировать эти проверки, а использовать средства Acl9 ?
  def can_create_forum?
    current_user_has_role? :administrator
  end

  def can_edit_forum?(forum)
    current_user_has_role? :administrator
  end
end
