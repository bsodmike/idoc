require 'spec_helper'

describe DocumentationPagesController, "Deleting a documentation page" do

  before(:each) do
    DocumentationPage.stub!(:find).and_return(@page = mock_model(DocumentationPage, :destroy => true))
  end

  def perform_action
    delete :destroy, :id => @page.id
  end

  context "User can destroy the page" do
    before(:each) do
      controller.stub!(:can?).and_return(true)
    end
    
    it "should check for the ability to destroy the documentation page" do
      controller.should_receive(:can?).with(:destroy, @page)
      perform_action
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

  context "user cant destroy the page" do
    before(:each) do
      controller.stub!(:can?).and_return(false)
    end

    it "should check for the ability to destroy the documentation page" do
      controller.should_receive(:can?).with(:destroy, @page)
      perform_action
    end

    it "should not destroy the page" do
      @page.should_not_receive(:destroy)
      perform_action
    end

    it "should redirect the user back to the page" do
      perform_action
      response.should redirect_to(documentation_page_url(@page))
    end

    it "should inform the user of a problem" do
      perform_action
      flash[:error].should contain("You are not allowed to destroy documentation pages")
    end
  end
end