class UserSessionsController < ApplicationController
  before_filter :find_menu_items, :only => :new
  def destroy
    @user_session = UserSession.find
    @user_session.destroy unless @user_session.nil?
    redirect_to root_url
  end

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    @user_session.save
    flash[:notice] = "Logged in successfully"
    redirect_to root_url
  end

end
