require 'spec_helper'

describe UserSessionsController, "Signing in (providing a logon form)" do
  def perform_action
    get :new
  end
  context "when not logged in" do
    before(:each) do
      UserSession.stub!(:find).and_return(nil)
      UserSession.stub!(:new).and_return(@user_session = mock_model(UserSession).as_new_record)
      controller.stub!(:can?).and_return(true)
    end

    it "should provide the data for a logon form" do
      UserSession.should_receive(:new)
      get :new
      assigns[:user_session].should == @user_session
    end
  end
  context "when logged in" do
    before(:each) do
      UserSession.stub!(:find).and_return(@user_session = mock_model(UserSession))
      controller.stub!(:can?).and_return(false)
    end

    it "should not create another session" do
      UserSession.should_not_receive(:new)
      get :new
    end

    it "should provide the user with the 403 screen" do
      perform_action
      response.should render_template('shared/403')
    end

    it "should respond with a 403 status code" do
      perform_action
      response.status.should contain("403")
    end
  end
end