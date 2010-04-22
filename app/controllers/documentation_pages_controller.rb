class DocumentationPagesController < ApplicationController
  before_filter :find_menu_items, :except => :destroy
  before_filter :store_location, :only => :show
  before_filter :find_documentation_page, :only => [:edit, :update, :show, :destroy]

  def new
    allowed_to? :create, DocumentationPage do
      setup_new_page
    end
  end

  def create
    allowed_to? :create, DocumentationPage do
      create_page
    end
  end

  def edit
    allowed_to? :update, @documentation_page do
      @all_documents = find_candidate_parent_pages
    end
  end

  def update
    allowed_to? :update, @documentation_page do
      update_page
    end
  end

  def show
    allowed_to? :read, @documentation_page do
      render :action => :show
    end
  end

  def destroy
    allowed_to? :destroy, @documentation_page do
      destroy_page
    end
  end

  def search
    @query = params[:search]
    result_set = DocumentationPage.search(@query)
    @results = []
    result_set.each do |page|
      begin
        @results << DocumentationPage.find(page.id)
      rescue ActiveRecord::RecordNotFound
        #Record isn't in the db anymore, just ignore it
      end
    end
  end

  def edit_tree
    allowed_to? :manage, DocumentationPage do
      @documentation_pages = DocumentationPage.all
    end
  end

  def update_tree
    allowed_to? :manage, DocumentationPage do
      DocumentationPage.update_tree(params[:documentation_tree])
      redirect_to root_url
    end
  end

  def root
    if DocumentationPage.roots.empty?
      display_new_page
    else
      display_first_page
    end
  end

  private

  def find_documentation_page
    @documentation_page = DocumentationPage.find(params[:id])
  end

  def display_new_page
    allowed_to? :create, DocumentationPage do
      setup_new_page
      render :action => :new
    end
  end

  def display_first_page
    @documentation_page = DocumentationPage.roots.first
    allowed_to? :read, @documentation_page do
      render :action => :show
    end
  end

  def setup_new_page
    @documentation_page = DocumentationPage.new
    @all_documents = DocumentationPage.find(:all)
  end

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

  def destroy_page
    @documentation_page.destroy
    flash[:notice] = "Page deleted"
    redirect_to root_url
  end

  def cannot_destroy_page
    flash[:error] = "You are not allowed to destroy documentation pages"
    redirect_to @documentation_page
  end
end
