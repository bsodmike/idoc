class DocumentationPagesController < ApplicationController
  before_filter :find_menu_items, :only => [:new, :create, :edit, :update, :show, :root]
  before_filter lambda{|cntrl| cntrl.require_logged_in("You must be logged on to add documentation")},
                :only => [:new, :create]
  before_filter lambda{|cntrl| cntrl.require_logged_in("You must be logged on to edit documentation")},
                :only => [:edit, :update]

  before_filter :store_location, :only => :show

  def new
    @documentation_page = DocumentationPage.new
    @all_documents = DocumentationPage.find(:all)
  end

  def create
    @documentation_page = DocumentationPage.create(params[:documentation_page])
    if @documentation_page.save
      flash[:notice] = "Page added"
      redirect_to documentation_page_url(@documentation_page)
    else
      flash[:error] = "Errors existed in the documentation page"
      @all_documents = DocumentationPage.find(:all)
      render :action => :new
    end

  end

  def edit
    @documentation_page = DocumentationPage.find(params[:id])
    @all_documents = DocumentationPage.find(:all) - [@documentation_page]
  end

  def update
    @documentation_page = DocumentationPage.find(params[:id])
    @documentation_page.update_attributes(params[:documentation_page])
    if @documentation_page.save
      flash[:notice] = "Page successfully updated"
      redirect_to @documentation_page
    else
      @all_documents = DocumentationPage.find(:all) - [@documentation_page]
      flash[:error] = "Errors occured during page update"
      render :action => :edit
    end
  end

  def show
    current_user
    @documentation_page = DocumentationPage.find params[:id]
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
end
