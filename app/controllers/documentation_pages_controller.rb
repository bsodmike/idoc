class DocumentationPagesController < ApplicationController
  before_filter :find_menu_items, :except => :destroy
  before_filter :store_location, :only => :show
  before_filter :find_documentation_page, :only => [:edit, :update, :show, :destroy]
  
  private

  def find_documentation_page
    @documentation_page = DocumentationPage.find(params[:id])
  end

  public

  include DocumentationPages::CreatePages

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

  include DocumentationPages::UpdatePages

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

  include DocumentationPages::DestroyPages
  
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

  include DocumentationPages::Index
  
  def index
    if DocumentationPage.roots.empty?
      display_new_page
    else
      display_first_page
    end
  end
end
