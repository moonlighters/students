module ForumTopicsHelper
  def link_to_topic(topic, options = {})
    link_to h( topic.title ), forum_topic_path( topic ), options
  end

  def will_paginate_topics(collection)
    will_paginate collection, :class => "topics_pagination"
  end
end
