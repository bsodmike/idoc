class UserSessionsController < ApplicationController
  before_filter :find_menu_items, :only => :new
  def destroy
    @user_session = UserSession.find
    @user_session.destroy unless @user_session.nil?
    redirect_to root_url
  end

  def new
  end

  def create
  end

end
