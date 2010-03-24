module DocumentationPagesControllerHelpers
  def setup_update_page
    setup_shared
    @doc_page.stub!(:update_attributes)
  end

  def setup_edit_form
    setup_shared
    create_all_pages_array(@doc_page)
  end

  def create_all_pages_array(current_page)
    @all_pages = Array.new(4) {mock_model(DocumentationPage)}
    @all_pages << current_page
    DocumentationPage.stub!(:find).with(:all).and_return(@all_pages)
  end

  private

  def setup_shared
    @failed_logon_error_message = "You must be logged on to edit documentation"
    @doc_page = mock_model(DocumentationPage, :save => true)
    DocumentationPage.stub!(:find).and_return(@doc_page)
  end
end

module DocumentationPageModelHelpers
  
end