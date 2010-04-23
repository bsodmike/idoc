module DocumentationPages::UpdatePages
  def find_candidate_parent_pages
    DocumentationPage.find(:all) - [@documentation_page]
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
end