module ForumPostsHelper
  def link_to_post(post, options = {})
    content = options[:content] || "Сообщение №#{post.id}"
    link_to h( content ), forum_topic_path( post.topic ) + "#post#{post.id}", options
  end
end
