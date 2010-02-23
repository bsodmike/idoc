class CommentsController < ApplicationController
  before_filter :find_menu_items, :only => [:new]
  def new
    
  end
end
