class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  filter_parameter_logging :password, :password_confirmation
  include App::SiteConfig
  include App::SessionManagement
  include App::Permissions
  include App::SiteMenu
end
