require 'spec_helper'

describe UserSessionsController, "Signing in (providing a logon form)" do
  context "when not logged in" do
    before(:each) do
      UserSession.stub!(:find).and_return(nil)
      UserSession.stub!(:new).and_return(@user_session = mock_model(UserSession).as_new_record)
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
    end

    it "should find the existing session" do
      UserSession.should_receive(:find)
      get :new
    end

    it "should not create another session" do
      UserSession.should_not_receive(:new)
      get :new
    end

    it "should inform the user about the problem" do
      get :new
      flash[:error].should contain("You are already logged in")
    end

    it "should return the user to the home page" do
      get :new
      response.should redirect_to(root_url)
    end
  end
end