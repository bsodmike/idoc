class UserSessionsController < ApplicationController
  before_filter :find_menu_items, :only => [:new, :create]

  def destroy
    @user_session = UserSession.find
    allowed_to? :destroy, @user_session do
      @user_session.destroy unless @user_session.nil?
      redirect_back_or_default root_url
    end
  end

  def new
    allowed_to? :create, UserSession do
      @user_session = UserSession.new
    end
  end

  def create
    allowed_to? :create, UserSession do
      @user_session = UserSession.new(params[:user_session])
      if @user_session.save
        successful_user_sign_in
      else
        unsuccessful_user_sign_in
      end
    end
  end

  private

  def unauthorized!
    render 'shared/403', :status => 403
  end
  
  def successful_user_sign_in
    set_successful_sign_in_message
    redirect_back_or_default root_url
  end

  def set_successful_sign_in_message
    flash[:notice] = "Logged in successfully"
  end

  def unsuccessful_user_sign_in
    set_failed_sign_in_error_message
    render :action => :new
  end

  def set_failed_sign_in_error_message
    if @user_session.account_inactive?
      flash[:error] = "Your account is not activated"
    else
      flash[:error] = "Username or password was incorrect"
    end
  end

end
