require 'spec_helper'

describe DocumentationPagesController, "Deleting a documentation page" do

  before(:each) do
    DocumentationPage.stub!(:find).and_return(@page = mock_model(DocumentationPage, :destroy => true))
  end

  def perform_action
    delete :destroy, :id => @page.id
  end

  it "should check for the ability to destroy the documentation page" do
    controller.should_receive(:can?).with(:destroy, @page)
    perform_action
  end

  context "User can destroy the page" do
    before(:each) do
      controller.stub!(:can?).and_return(true)
    end

    it "should destroy the page" do
      @page.should_receive(:destroy)
      perform_action
    end

    it "should redirect the user to the root page" do
      perform_action
      response.should redirect_to(root_url)
    end
  end

  it_should_behave_like "deny access to area with 403 and user login"
end