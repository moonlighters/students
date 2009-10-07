# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  protect_from_forgery # :secret => 'cd5d422483a22ae5412c6491ed1d740e'

  helper_method :current_user_session, :current_user,
                :smart_post_path, :current_user_has_role?, :current_user_group
  filter_parameter_logging :password, :password_confirmation

  rescue_from Acl9::AccessDenied, :with => :access_denied

  def root
  end
  
  # GET /info
  def info
  end

  private
    # Override these 2 methods in the particular controller to change behavior when access denied
    def access_denied_redirect_url
      root_url
    end
    def access_denied_message
      "У вас недостаточно прав для доступа к этому разделу!"
    end

    def access_denied
      unless current_user
        require_user 
      else
        flash[:error] = access_denied_message
        redirect_to access_denied_redirect_url
      end
    end

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def require_user
      unless current_user
        store_location
        flash[:notice] = "Вы должны войти, чтобы получить доступ к этой странице."
        redirect_to login_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "Вы должны выйти из системы, чтобы получить доступ к этой странице."
        redirect_to logout_url
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end 

    def smart_post_path(post)
      return nil unless post
      topic = post.topic
      page = 1 + topic.posts.index( post ) / ForumPost.per_page
      forum_topic_path( post.topic ) + "?page=#{page}#post#{post.id}"
    end

    def current_user_has_role?(*args)
      current_user and current_user.has_role? *args
    end

    def current_user_group
      current_user.group if current_user
    end
end
