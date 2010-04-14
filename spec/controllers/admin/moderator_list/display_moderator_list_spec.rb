require 'spec_helper'

describe Admin::ModeratorListController, "Display the moderators list" do
  def perform_action
    get :show
  end

  it "should check the user can read the moderators list" do
    controller.should_receive(:can?).with(:read, ModeratorList)
    perform_action
  end

  context "User can read the moderator list" do
    before(:each) do
      controller.stub(:can?).and_return(true)
    end
    
    it "should retrieve moderators" do
      ModeratorList.should_receive(:moderators).and_return([])
      perform_action
    end
  end

  it_should_behave_like "deny access to area with 403 and user login"
end