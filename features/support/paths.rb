module NavigationHelpers
  def path_to(page_name)
    case page_name
    
    when /список форумов/
      forums_path

    when /главн(?:ую|ая)/
      root_path
    
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
