require 'spec_helper'

describe DocumentationPagesController, "providing a blank documentation page" do
  before(:each) do
    @failed_logon_error_message = "You must be logged on to add documentation"
    @doc_page = mock_model(DocumentationPage, :save => true)
    DocumentationPage.stub!(:new).and_return(@doc_page)
    controller.stub!(:can?).and_return(true)
  end
  def perform_action
    get :new
  end
  it_should_behave_like "finding menu items"

  context "User is allowed to create page" do
    it "should check for the create permission of DocumentationPage" do
      controller.should_receive(:can?).with(:create, DocumentationPage)
      perform_action
    end
    
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

  context "User is not allowed to create page" do
    context "User is not identified" do
      before(:each) do
        controller.stub!(:can?).and_return(false)
      end
      it "should redirect the user to the account logon page" do
        perform_action
        response.should redirect_to(new_user_session_url)
      end

      it "should inform the user of the problem" do
        perform_action
        flash[:error].should contain("You must be logged on to add documentation")
      end
    end
  end
end