module NavigationHelpers
  def path_to(page_name)
    case page_name

    when /главн(?:ую|ая)/
      root_path
    
    when /спис(?:ок|ке) загрузок/
      loads_path

    when /загрузк[уе] (.+)/
      load_path( Load.find_by_name! $1 )

    when /спис(?:ок|ке) предметов/
      lesson_subjects_path

    when /предмет[еу]? (.+)/
      lesson_subject_path( LessonSubject.find_by_name! $1 )

    when /спис(?:ок|ке) групп/
      groups_path

    when /групп[аеу] (.+)/
      group_path( Group.find_by_name! $1 )

    when /спис(?:ок|ке) преподавателей/
      teachers_path

    when /страничк[аеу] преподавателя (.+) (.+)/
      teacher_path( Teacher.find_by_name_and_surname! $1, $2 )

    when /страничк[аеу] пользователя (.+)/
      user_path( User.find_by_nickname! $1 )

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in features/support/paths.rb"
    end
  end
end

World(NavigationHelpers)
