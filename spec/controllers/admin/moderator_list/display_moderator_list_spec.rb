require 'spec_helper'

describe Admin::ModeratorListController, "Display the moderators list" do

  before(:each) do
    controller.stub!(:can?).and_return(true)
  end
  
  def perform_action
    get :show
  end

  it "should check the user can read the moderators list" do
    controller.should_receive(:can?).with(:read, ModeratorList)
    perform_action
  end

  it "should retrieve moderators" do
    ModeratorList.should_receive(:moderators).and_return([])
    perform_action
  end
end