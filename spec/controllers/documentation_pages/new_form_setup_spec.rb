require 'spec_helper'

describe DocumentationPagesController, "providing a blank documentation page" do
  before(:each) do
    @failed_logon_error_message = "You must be logged on to add documentation"
    @doc_page = mock_model(DocumentationPage, :save => true)
    DocumentationPage.stub!(:new).and_return(@doc_page)
  end
  def perform_action
    get :new
  end
  it_should_behave_like "finding menu items"
  it_should_behave_like "requires user logon"

  it "should set up the data for a new page" do
    DocumentationPage.should_receive(:new).and_return(doc_page = mock_model(DocumentationPage))
    get :new
    assigns(:documentation_page).should == doc_page
  end
  it "should find all the documentation pages" do
    DocumentationPage.should_receive(:find).with(:all).and_return(@all_pages)
    get :new
  end
end