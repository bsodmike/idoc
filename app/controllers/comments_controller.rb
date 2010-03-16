class CommentsController < ApplicationController
  before_filter :find_menu_items, :only => [:new, :create]
  before_filter lambda{|cntrl| cntrl.require_logged_in("You must be logged on to add a comment")}

  def new
    @documentation_page = DocumentationPage.find(params[:documentation_page_id])
    @comment = build_comment(@documentation_page)
  end

  def create
    @documentation_page = DocumentationPage.find(params[:documentation_page_id])
    @comment = build_comment(@documentation_page, params[:comment])
    if @comment.save
      successful_action
    else
      unsuccessful_action
    end

  end

  private

  def build_comment(parent, comment_params = nil)
    comment = parent.comments.build(comment_params)
    comment.user = current_user
    return comment
  end

  def successful_action
    flash[:notice] = "Comment added"
    redirect_to @documentation_page
  end

  def unsuccessful_action
    flash[:error] = "Your comment could not be saved"
    render :action => :new
  end
end
