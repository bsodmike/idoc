class DocumentationPagesController < ApplicationController
  before_filter :find_menu_items, :only => [:new, :create, :edit, :update, :show, :root]
  before_filter :store_location, :only => :show

  def new
    if can? :create, DocumentationPage
      @documentation_page = DocumentationPage.new
      @all_documents = DocumentationPage.find(:all)
    else
      cant_create_page
    end
  end

  def create
    if can? :create, DocumentationPage
      create_page
    else
      cant_create_page
    end
  end

  def edit
    @documentation_page = DocumentationPage.find(params[:id])
    if can? :update, @documentation_page
      @all_documents = find_candidate_parent_pages
    else
      flash[:error] = "You must be logged on to edit documentation"
      redirect_to new_user_session_url
    end
  end

  def update
    @documentation_page = DocumentationPage.find(params[:id])
    if can? :update, @documentation_page
      update_page
    else
      cant_update_page
    end
  end

  def show
    current_user
    @documentation_page = DocumentationPage.find params[:id]
  end

  def destroy
    @documentation_page = DocumentationPage.find(params[:id])
    @documentation_page.destroy if can? :manage, @documentation_page
    flash[:notice] = "Page deleted"
    redirect_to root_url
  end

  def root
    if DocumentationPage.roots.empty?
      if require_logged_in("You must be logged on to add documentation")
        @all_documents = DocumentationPage.find(:all)
        @documentation_page = DocumentationPage.new
        render :action => :new
      end
    else
      current_user
      @documentation_page = DocumentationPage.roots[0]
      render :action => :show
    end
  end

  private

  def create_page
    @documentation_page = DocumentationPage.new(params[:documentation_page])
    @documentation_page.save!
    flash[:notice] = "Page added"
    redirect_to documentation_page_url(@documentation_page)
  rescue
    failed_page_creation
  end

  def failed_page_creation
    flash[:error] = "Errors existed in the documentation page"
    @all_documents = DocumentationPage.find(:all)
    render :action => :new
  end

  def update_page
    @documentation_page.update_attributes!(params[:documentation_page])
    flash[:notice] = "Page successfully updated"
    redirect_to @documentation_page
  rescue
    failed_page_update
  end

  def failed_page_update
    @all_documents = find_candidate_parent_pages
    flash[:error] = "Errors occured during page update"
    render :action => :edit
  end

  def cant_create_page
    flash[:error] = "You must be logged on to add documentation"
    redirect_to new_user_session_url
  end

  def cant_update_page
    flash[:error] = "You must be logged on to edit documentation"
    redirect_to new_user_session_url
  end

  def find_candidate_parent_pages
    DocumentationPage.find(:all) - [@documentation_page]
  end
end
