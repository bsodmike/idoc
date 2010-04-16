require 'spec_helper'

describe Admin::DocumentAuthorListController, "Set up the variables for editing the document author list" do
  def perform_action
    get :edit
  end
  
  it_should_behave_like "deny access to area with 403 and user login"

  it "should check the user can update the document author list" do
    controller.should_receive(:can?).with(:update, DocumentAuthorList)
    perform_action
  end

  context "User can update the document author list" do
    before(:each) do
      controller.stub!(:can?).and_return(true)
    end

    it "should find the current document authors" do
      DocumentAuthorList.should_receive(:authors)
      perform_action
    end

    it "should find the current users" do
      DocumentAuthorList.should_receive(:users)
      perform_action
    end
  end
  
end
