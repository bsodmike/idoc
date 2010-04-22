require 'spec_helper'

describe DocumentationPagesController, "Providing the data for a form to edit the entire documentation tree" do
  def perform_action
    post :update_tree, :documentation_tree => {} 
  end
  it_should_behave_like "finding menu items"
  it_should_behave_like "deny access to area with 403 and user login"

  it "should check the user can manage documentation pages" do
    controller.should_receive(:can?).with(:manage, DocumentationPage)
    perform_action
  end

  context "User is allowed to manage documentation pages" do
    before(:each) do
      controller.stub!(:can?).and_return(true)
      DocumentationPage.stub!(:update_tree)
    end

    it "should update the documentation tree" do
      DocumentationPage.should_receive(:update_tree).with({})
      perform_action
    end

    it "should redirect the user to the root page" do
      perform_action
      response.should redirect_to(root_url)
    end
  end
end
