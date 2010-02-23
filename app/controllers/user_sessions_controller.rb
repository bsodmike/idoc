class UserSessionsController < ApplicationController
  before_filter :find_menu_items, :only => [:new, :create]
  before_filter lambda{|cntrl| cntrl.require_logged_out("You are already logged in")}, :only => [:new, :create]

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
    if @user_session.save
      flash[:notice] = "Logged in successfully"
      redirect_to root_url
    else
      if @user_session.attempted_record && !@user_session.attempted_record.active?
        flash[:error] = "Your account is not activated"
      else
        flash[:error] = "Username or password was incorrect"
      end
      render :action => :new
    end
  end
end
