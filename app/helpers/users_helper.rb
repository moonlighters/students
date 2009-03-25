module UsersHelper
  def link_to_user(user, options={})
    raise "Invalid user" unless user
    u = User.find user[:id]
    content = options[:content] || u.login
    options[:content] = nil
    link_to h( content ), user_path(u), options
  end
end
