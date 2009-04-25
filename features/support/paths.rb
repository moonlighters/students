module NavigationHelpers
  def path_to(page_name)
    case page_name

    when /главн(?:ую|ая)/
      root_path
    
    when /спис(?:ок|ке) форумов/
      forums_path

    when /форум(?:е)? (.+)/
      forum_path( Forum.find_by_title! $1 )

    when /тем[еау] (.+)/
      forum_topic_path( ForumTopic.find_by_title! $1 )

    when /редактировани(?:е|и) темы (.+)/
      edit_forum_topic_path( ForumTopic.find_by_title! $1 )

    when /сообщени[ея] "([^\"]*)"/
      edit_forum_post_path( ForumPost.find_by_body! $1 )

    when /спис(?:ок|ке) предметов/
      lesson_subjects_path

    when /предмет[еу]? (.+)/
      lesson_subject_path( LessonSubject.find_by_name! $1 )

    # Add more page name => path mappings here
    
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in features/support/paths.rb"
    end
  end
end

World do |world|
  world.extend NavigationHelpers
  world
end
