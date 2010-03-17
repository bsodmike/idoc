require 'spec_helper'

describe DocumentationPagesController, "displaying a documentation page" do
  def perform_action
    get :show, :id => @doc_page.id
  end
  it_should_behave_like "finding menu items"

  before(:each) do
    UserSession.stub!(:find).and_return(nil)
    @doc_page = mock_model(DocumentationPage)
    DocumentationPage.stub!(:find).and_return(@doc_page)
  end
  it "should find the documentation page" do
    perform_action
    assigns(:documentation_page).should == @doc_page
  end

  context "with an identified user" do
    it "should find the identified user" do
      perform_action
      assigns[:current_user].should == user
    end
  end
end