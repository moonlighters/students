module NavigationHelpers
  def path_to(page_name)
    case page_name

    when /главн(?:ую|ая)/
      root_path
    
    when /список форумов/
      forums_path

    when /форум(?:е)? (.+)/
      forum_path( Forum.find_by_title $1 )

    when /создании форума/
      forums_path

    when /редактировании форума (.+)/
      forum_path( Forum.find_by_title $1 )

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
