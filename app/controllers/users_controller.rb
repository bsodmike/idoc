class UsersController < ApplicationController
  before_filter :find_menu_items

  def new
    allowed_to? :create, UserSession do
      @user = User.new
    end
  end

  def create
    allowed_to? :create, UserSession do
      @user = User.new(params[:user])
      if @user.save_without_session_maintenance
        successful_action("Sign-up successful")
      else
        unsuccessful_action
      end
    end
  end

  def confirm
    allowed_to? :confirm, User do
      @user = User.find_by_perishable_token(params[:activation_token])
      @user.activate!
      successful_action("Account activated")
    end
  end

  private

  def unauthorized!
    render 'shared/403', :status => 403
  end

  def successful_action(success_message)
    flash[:notice] = success_message
    redirect_back_or_default new_user_session_url
  end

  def unsuccessful_action
    flash[:error] = "There were errors in the user data provided"
    render :action => :new
  end
end
