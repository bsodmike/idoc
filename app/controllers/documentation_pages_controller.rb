class DocumentationPagesController < ApplicationController
  before_filter :find_menu_items, :only => [:new, :create, :edit, :show]
  before_filter lambda{|cntrl| cntrl.require_logged_in("You must be logged on to add documentation")},
                :only => [:new, :create]
  
  def new
    @documentation_page = DocumentationPage.new
  end
  
  def create
    @documentation_page = DocumentationPage.create(params[:documentation_page])
    if @documentation_page.save
      redirect_to documentation_page_url(@documentation_page)
    else
      flash[:error] = "Errors existed in the documentation page"
      render :action => :new
    end
    
  end

  def edit
    @documentation_page = DocumentationPage.find(params[:id])
    
  end

  def update
    
  end

  def show
    @user_session = UserSession.find
    @current_user = @user_session ? @user_session.record : nil
    @documentation_page = DocumentationPage.find params[:id]
  end
end
