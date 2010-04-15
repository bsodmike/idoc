require 'spec_helper'

describe Admin::ModeratorListController, "Update the moderator list" do
  before(:each) do
    ModeratorList.stub!(:update_list)
    @params = {}
  end

  def perform_action
    put :update, :moderator_list => @params
  end

  it_should_behave_like "deny access to area with 403 and user login"

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

    context "providing feedback" do
      it "should add 'Moderator added' to the notice when a single moderator is added" do
        @params = {:add_moderators => [1]}
        perform_action
        flash[:notice].should contain("Moderator added")
      end

      it "should add 'Moderators added' to the notice when several moderators are added" do
        @params = {:add_moderators => [1, 2]}
        perform_action
        flash[:notice].should contain("Moderators added")
      end

      it "should add 'Moderator removed' to the notice when a single moderator is removed" do
        @params = {:remove_moderators => [1]}
        perform_action
        flash[:notice].should contain("Moderator removed")
      end

      it "should add 'Moderators removed' to the notice when several moderators are removed" do
        @params = {:remove_moderators => [1, 2]}
        perform_action
        flash[:notice].should contain("Moderators removed")
      end
    end
  end
end