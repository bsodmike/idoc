require 'spec_helper'

describe DocumentationPagesController, "editing an existing page (providing the form)" do
  before(:each) do
    setup_edit_form
  end
  def perform_action
    get :edit, :id => @doc_page.id
  end
  it_should_behave_like "finding menu items"

  it "should check the user has update permission for the page" do
    controller.should_receive(:can?).with(:update, @doc_page)
    perform_action
  end

  it "should find the documentation page" do
    perform_action
    assigns[:documentation_page].should == @doc_page
  end

  context "User can update the page" do
    before(:each) do
      controller.stub!(:can?).and_return(true)
    end

    it "should find all the documentation pages" do
      DocumentationPage.should_receive(:find).with(:all).and_return(@all_pages)
      perform_action
    end

    it "should remove the current page from it's all_documents output" do
      perform_action
      assigns[:all_documents].should == (@all_pages - [@doc_page])
    end
  end

  it_should_behave_like "deny access to area with 403 and user login"
end