require 'spec_helper'

describe DocumentationPagesController, "displaying a documentation page" do
  def perform_action
    get :show, :id => @doc_page.id
  end
  it_should_behave_like "finding menu items"
  it_should_behave_like "deny access to area with 403 and user login"

  before(:each) do
    UserSession.stub!(:find).and_return(nil)
    @doc_page = mock_model(DocumentationPage)
    DocumentationPage.stub!(:find).and_return(@doc_page)
  end

  it "should check the user can view the page" do
    controller.should_receive(:can?).with(:read, @doc_page)
    perform_action
  end

  context "User can read the page" do
    before(:each) do
      controller.stub!(:can?).and_return(true)
    end

    it "should find the documentation page" do
      perform_action
      assigns(:documentation_page).should == @doc_page
    end

    it "should render the show template" do
      perform_action
      response.should render_template('documentation_pages/show')
    end
  end
end