require 'spec_helper'

describe UserSessionsController, "Logging in (creating an authenticated session)" do
  def perform_action
    post :create, :user_session => {}
  end

  it "should check the user has permission to create a session" do
    controller.should_receive(:can?).with(:create, UserSession)
    perform_action
  end

  context "when the user is logged out" do
    before(:each) do
      controller.stub!(:can?).and_return(true)
    end
    context "and user provides valid credentials" do
      before(:each) do
        UserSession.stub!(:find).and_return(nil)
        UserSession.stub!(:new).and_return(@user_session = mock_model(UserSession, :save => true))
        @valid_credentials = {}
      end

      it "should create the session" do
        UserSession.should_receive(:new).with(@valid_credentials)
        post :create, :user_session => @valid_credentials
      end

      it "should save the session" do
        @user_session.should_receive(:save)
        post :create, :user_session => @valid_credentials
      end

      it "should inform the user of a successful sign in" do
        post :create, :user_session => @valid_credentials
        flash[:notice].should contain("Logged in successfully")
      end

      it "should send the user to the home page" do
        post :create, :user_session => @valid_credentials
        response.should redirect_to(root_url)
      end
    end

    context "and user provides invalid credentials" do
      before(:each) do
        UserSession.stub!(:find).and_return(nil)
        UserSession.stub!(:new).and_return(@user_session = mock_model(UserSession, :save => false,
                                                                      :account_inactive? => false))
        @invalid_credentials = {}
      end

      it "should create the session" do
        UserSession.should_receive(:new).with(@invalid_credentials)
        post :create, :user_session => @invalid_credentials
      end

      it "should attempt to save the session" do
        @user_session.should_receive(:save)
        post :create, :user_session => @invalid_credentials
      end

      it "should check for an attempted record" do
        @user_session.should_receive(:account_inactive?)
        post :create, :user_session => @invalid_credentials
      end

      it "should inform the user of the failed attempt" do
        post :create, :user_session => @invalid_credentials
        flash[:error].should contain("Username or password was incorrect")
      end

      it "should provide the user with the login form to retry" do
        post :create, :user_session => @invalid_credentials
        response.should render_template("user_sessions/new")
      end
    end
  end

  context "when the user is logged in" do
    before(:each) do
      UserSession.stub!(:find).and_return(@user_session = mock_model(UserSession))
      @credentials = {}
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

  context "when the user account isn't activated" do
    before(:each) do
      UserSession.stub!(:find).and_return(nil)
      UserSession.stub!(:new).and_return(@user_session = mock_model(UserSession, :save => false,
                                                                    :account_inactive? => true))
      @valid_credentials = {}
      controller.stub!(:can?).and_return(true)
    end

    it "should create the session" do
      UserSession.should_receive(:new).with(@valid_credentials)
      post :create, :user_session => @valid_credentials
    end

    it "should attempt to save the session" do
      @user_session.should_receive(:save)
      post :create, :user_session => @valid_credentials
    end

    it "should inform the user of their account status" do
      post :create, :user_session => @valid_credentials
      flash[:error].should contain("Your account is not activated")
    end

    it "should provide the user with the login form again" do
      post :create, :user_session => @valid_credentials
      response.should render_template("user_sessions/new")
    end
  end
end