class CommentsController < ApplicationController
  before_filter :find_menu_items, :only => [:new, :create]
  before_filter :find_documentation_page

  def new
    can_create_comment? do
      @comment = build_comment(@documentation_page)
    end
  end

  def create
    can_create_comment? do
      begin
        create_comment!(@documentation_page, params[:comment])
        created_successfully
      rescue
        create_failed
      end
    end
  end

  private

  def can_create_comment?
    if can? :create, Comment
      yield
    else
      failed_can?
    end
  end

  def find_documentation_page
    @documentation_page = DocumentationPage.find(params[:documentation_page_id])
  end

  def create_comment!(parent, comment_params = nil)
    @comment = build_comment(parent, comment_params)
    @comment.save!
  end

  def build_comment(parent, comment_params = nil)
    comment = parent.comments.build(comment_params)
    comment.user = current_user
    return comment
  end

  def created_successfully
    flash[:notice] = "Comment added"
    redirect_to @documentation_page
  end

  def create_failed
    flash[:error] = "Your comment could not be saved"
    render :action => :new
  end

  def failed_can?
    flash[:error] = "You must be logged in to post comments"
    redirect_to new_user_session_url
  end
end
