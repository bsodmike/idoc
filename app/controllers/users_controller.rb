class UsersController < ApplicationController

  before_filter :find_menu_items
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Sign-up successful"
      redirect_to user_path(@user)
    else
      flash[:error] = "There were errors in the user data provided"
      render :action => :new
    end
    
  end

  def show
  end

end
