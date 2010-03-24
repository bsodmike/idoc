class UsersController < ApplicationController

  before_filter :find_menu_items
  before_filter lambda{|cntrl| cntrl.require_logged_out("You already have an account")}, :only => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save_without_session_maintenance
      successful_action("Sign-up successful")
    else
      unsuccessful_action
    end

  end

  def confirm
    @user = User.find_by_perishable_token(params[:activation_token])
    @user.activate!
    successful_action("Account activated")
  end

private

  def successful_action(success_message)
    flash[:notice] = success_message
    redirect_back_or_default new_user_session_url
  end

  def unsuccessful_action
    flash[:error] = "There were errors in the user data provided"
    render :action => :new
  end
end
