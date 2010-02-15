class DocumentationPagesController < ApplicationController
  before_filter :find_menu_items, :only => [:new, :show]
  def new
    @documentation_page = DocumentationPage.new
  end
  
  def create
    @documentation_page = DocumentationPage.create(params[:documentation_page])
    @documentation_page.save
    redirect_to documentation_page_url(@documentation_page)
  end

  def show
    @documentation_page = DocumentationPage.find params[:id]
  end
end
