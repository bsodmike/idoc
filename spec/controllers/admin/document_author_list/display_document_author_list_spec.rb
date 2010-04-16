require 'spec_helper'

describe Admin::DocumentAuthorListController, "Display the document authors list" do
  def perform_action
    get :show
  end

  it_should_behave_like "deny access to area with 403 and user login"

  it "should check the user can read the document authors list" do
    controller.should_receive(:can?).with(:read, DocumentAuthorList)
    perform_action
  end

  context "User can read the document authors list" do
    before(:each) do
      controller.stub(:can?).and_return(true)
    end

    it "should retrieve document authors" do
      DocumentAuthorList.should_receive(:authors).and_return([])
      perform_action
    end
  end
end