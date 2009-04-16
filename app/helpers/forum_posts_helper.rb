module ForumPostsHelper
  def link_to_post(post, options = {})
    return nil unless post
    content = options[:content] || "Сообщение №#{post.id}"
    link_to h( content ), smart_post_path( post ), options
  end

  def will_paginate_posts(collection)
    will_paginate collection, :class => "posts_pagination"
  end
end
