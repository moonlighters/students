module GroupsHelper
  def link_to_group(group)
    return if group.nil?
    link_to h( group.name ), group_path( group )
  end
end
