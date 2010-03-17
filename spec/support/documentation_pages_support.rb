module DocumentationPagesControllerHelpers
  def setup_edit_form
    @failed_logon_error_message = "You must be logged on to edit documentation"
    @doc_page = mock_model(DocumentationPage)
    create_all_pages_array(@doc_page)
    DocumentationPage.stub!(:find).and_return(@doc_page)
  end

  private

  def create_all_pages_array(current_page)
    @all_pages = Array.new(4) {mock_model(DocumentationPage)}
    @all_pages << current_page
    DocumentationPage.stub!(:find).with(:all).and_return(@all_pages)
  end
end

module DocumentationPageModelHelpers
  
end