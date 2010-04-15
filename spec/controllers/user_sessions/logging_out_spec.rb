require 'spec_helper'

describe UserSessionsController, "Logging out (destroying the session)" do
  def perform_action
    delete :destroy
  end

  it "should check the user can destroy a session" do
    UserSession.stub!(:find).and_return(user_session = mock_model(UserSession))
    controller.should_receive(:can?).with(:destroy, user_session)
    perform_action
  end

  context "when the user is logged in" do
    before(:each) do
      UserSession.stub!(:find).and_return(@user_session = mock_model(UserSession, :destroy => true))
      controller.stub!(:can?).and_return(true)
    end
    it "should find the session" do
      UserSession.should_receive(:find)
      delete :destroy
    end

    it "should destroy the session" do
      @user_session.should_receive(:destroy)
      delete :destroy
    end

    it "should redirect to the home page" do
      delete :destroy
      response.should redirect_to(root_url)
    end
  end

  context "when the user is logged out" do
    before(:each) do
      UserSession.stub!(:find).and_return(nil)
      controller.stub!(:can?).and_return(false)
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