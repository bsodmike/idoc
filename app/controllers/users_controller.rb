class UsersController < ApplicationController

  before_filter :find_menu_items

  before_filter :check_logged_in, :only => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save_without_session_maintenance
      flash[:notice] = "Sign-up successful"
      redirect_to user_path(@user)
    else
      flash[:error] = "There were errors in the user data provided"
      render :action => :new
    end

  end

  def confirm
    @user = User.find_by_perishable_token(params[:activation_token])
    @user.activate!
    flash[:notice] = "Account activated"
    redirect_to new_user_session_url
  end

  def show
  end

  def check_logged_in
    if UserSession.find
      flash[:error] = "You already have an account"
      redirect_to root_url
      return false
    end
    return true
  end
end
