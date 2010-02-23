# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def find_menu_items
    @menu_items = DocumentationPage.find :all
  end

  def require_logged_out(message)
    if UserSession.find
      flash[:error] = message
      redirect_to root_url
      return false
    else
      return true
    end
  end

  def require_logged_in(message)
    if !UserSession.find
      flash[:error] = message
      redirect_to new_user_session_url
      return false
    else
      return true
    end
  end
end
