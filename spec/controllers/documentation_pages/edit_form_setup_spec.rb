require 'spec_helper'

describe DocumentationPagesController, "editing an existing page (providing the form)" do
  before(:each) do
    setup_edit_form
  end
  def perform_action
    get :edit, :id => @doc_page.id
  end
  it_should_behave_like "finding menu items"
  it_should_behave_like "requires user logon"

  it "should find the documentation page" do
    perform_action
    assigns[:documentation_page].should == @doc_page
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