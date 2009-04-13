module ForumPostsHelper
  def link_to_post(post, options = {})
    return nil unless post
    content = options[:content] || "Сообщение №#{post.id}"
    link_to h( content ), smart_post_path( post ), options
  end
end
