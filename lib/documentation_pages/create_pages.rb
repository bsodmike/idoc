module DocumentationPages::CreatePages
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
end