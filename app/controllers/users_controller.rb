class UsersController < ApplicationController

  before_filter :find_menu_items
  
  def new
    @user = User.new
  end

  def create
  end

  def show
  end

end
