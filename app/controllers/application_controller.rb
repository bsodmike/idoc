class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  filter_parameter_logging :password, :password_confirmation
  include Application::SiteConfig
  include Application::SessionManagement
  include Application::Permissions
  include Application::SiteMenu
end
