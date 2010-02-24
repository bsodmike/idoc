class CommentsController < ApplicationController
  before_filter :find_menu_items, :only => [:new, :create]
  def new
    @documentation_page = DocumentationPage.find(params[:documentation_page_id])
    @comment = @documentation_page.comments.build
  end

  def create
    @documentation_page = DocumentationPage.find(params[:documentation_page_id])
    @comment = @documentation_page.comments.build(params[:comment])
    if @comment.save
      flash[:notice] = "Comment added"
      redirect_to @documentation_page
    else
      flash[:error] = "Your comment could not be saved"
      render :action => :new
    end
    
  end
end
