module ForumPostsHelper
  def link_to_post(post, options = {})
    return nil unless post
    content = options[:content] || "Сообщение №#{post.id}"
    link_to h( content ), smart_post_path( post ), options
  end

  def will_paginate_posts(collection)
    will_paginate collection, :class => "posts_pagination"
  end

  # TODO: можно ли как-то не дублировать эти проверки, а использовать средства Acl9 ?
  def can_create_post?
    current_user
  end

  def can_edit_post?(post)
    post.owner?( current_user ) or current_user_has_role?( :moderator, post.topic.forum ) 
  end
end
