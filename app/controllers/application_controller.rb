# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def find_menu_items
    @menu_items = DocumentationPage.roots
  end

  def require_logged_out(message)
    if current_session
      flash[:error] = message
      redirect_to root_url
      return false
    else
      return true
    end
  end

  def require_logged_in(message)
    if !current_session
      flash[:error] = message
      redirect_to new_user_session_url
      return false
    else
      current_user
      return true
    end
  end

  def current_session
    return @current_session if @current_session
    @current_session = UserSession.find
  end

  def current_user
    return @current_user if @current_user
    if current_session
      @current_user = current_session.record
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  protected
  
  def unauthorized!
    if current_user
      render 'shared/403', :status => 403
    else
      flash[:error] = "You must be logged in to access this area"
      redirect_to new_user_session_url
    end
  end
  
  def allowed_to?(permission, object)
    if can? permission, object
      yield
    else
      unauthorized!
    end
  end
end
