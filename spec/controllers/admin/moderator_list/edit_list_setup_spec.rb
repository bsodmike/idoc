require 'spec_helper'

describe Admin::ModeratorListController, "Setup the edit moderator list form" do
  def perform_action
    get :edit  
  end
  it_should_behave_like "deny access to area with 403 and user login"

  context "User can edit the moderator list" do
    before(:each) do
      controller.stub!(:can?).and_return(true)
      ModeratorList.stub!(:moderators).and_return([])
    end

    it "should check the user can edit the moderator list" do
      controller.should_receive(:can?).with(:update, ModeratorList)
      perform_action
    end

    it "should find the list of moderators" do
      ModeratorList.should_receive(:moderators)
      perform_action
    end

    it "should find the list of users" do
      ModeratorList.should_receive(:users)
      perform_action
    end
  end
end