require 'spec_helper'

describe CommentsController, "Obtaining a list of recent comments" do
  def perform_action
    get :recent
  end

  it_should_behave_like "deny access to area with 403 and user login"

  it "should check the user can manage comments" do
    controller.should_receive(:can?).with(:manage, Comment)
    perform_action
  end

  context "User can manage comments" do
    before(:each) do
      controller.stub!(:can?).and_return(true)
    end

    it "should obtain comments in a list of most recent to least" do
      Comment.should_receive(:recent).and_return([])
      perform_action
      assigns[:comments].should == []
    end
  end
end