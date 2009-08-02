module ForumTopicsHelper

  def link_to_topic(topic, options = {})
    link_to h( topic.title ), forum_topic_path( topic ), options
  end

  def will_paginate_topics(collection)
    will_paginate collection, :class => "topics_pagination"
  end

  # TODO: можно ли как-то не дублировать эти проверки, а использовать средства Acl9 ?
  def can_create_topic?
    current_user
  end

  def can_edit_topic?(topic)
    topic.owner?( current_user ) or current_user_has_role?( :moderator, topic.forum ) 
  end
end
