require 'spec_helper'

describe Admin::ModeratorListController, "Update the moderator list" do
  before(:each) do
    ModeratorList.stub!(:update_list)
    @params = {}
  end
  def perform_action
    put :update, :moderator_list => @params
  end

  it "should check the user can update the list" do
    controller.should_receive(:can?).with(:update, ModeratorList)
    perform_action
  end
  
  context "User can update list" do
    before(:each) do
      controller.stub!(:can?).and_return(true)
    end

    it "should update the moderator list" do
      ModeratorList.should_receive(:update_list).with(@params)
      perform_action
    end

    it "should redirect the user to the moderator list" do
      perform_action
      response.should redirect_to(admin_moderator_list_url)
    end

    it "should provide the user with a successful feedback" do
      perform_action
      flash[:notice].should contain("Moderator added")
    end
  end

  it_should_behave_like "deny access to area with 403 and user login"
end