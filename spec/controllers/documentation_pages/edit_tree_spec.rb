require 'spec_helper'

describe DocumentationPagesController, "Providing the data for a form to edit the entire documentation tree" do
  def perform_action
    get :edit_tree
  end
  it_should_behave_like "finding menu items"
  it_should_behave_like "deny access to area with 403 and user login"

  it "should check the user can manage documentation pages" do
    controller.should_receive(:can?).with(:manage, DocumentationPage)
    perform_action
  end

  context "User can manage documentation pages" do
    before(:each) do
      controller.stub!(:can?).and_return(true)
    end

    it "should obtain all the documentation pages" do
      DocumentationPage.should_receive(:all).and_return([])
      perform_action
      assigns[:documentation_pages].should == []
    end
  end
end