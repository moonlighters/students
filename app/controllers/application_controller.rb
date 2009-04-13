# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  protect_from_forgery # :secret => 'cd5d422483a22ae5412c6491ed1d740e'

  helper_method :current_user_session, :current_user,
                :smart_post_path
  filter_parameter_logging :password, :password_confirmation

  def root
  end
  
  private
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
      forum_topic_path( post.topic ) + "#post#{post.id}"
    end
end
