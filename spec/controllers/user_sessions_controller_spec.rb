require 'spec_helper'

describe UserSessionsController do
  context "Logging out (destroying the session)" do
    context "when the user is logged in" do
      before(:each) do
        UserSession.stub!(:find).and_return(@user_session = mock_model(UserSession, :destroy => true))
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
      end
      it "should find the session" do
        UserSession.should_receive(:find)
        delete :destroy
      end

      it "should redirect to the home page" do
        delete :destroy
        response.should redirect_to(root_url)
      end
    end
  end

  context "Logging in (creating an authenticated session)" do
    context "when the user is logged out" do
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
      end

      it "should find the existing session" do
        UserSession.should_receive(:find)
        post :create, :user_session => @credentials
      end

      it "should not create another session" do
        UserSession.should_not_receive(:new)
        post :create, :user_session => @credentials
      end

      it "should inform the user about the problem" do
        post :create, :user_session => @credentials
        flash[:error].should contain("You are already logged in")
      end

      it "should return the user to the home page" do
        post :create, :user_session => @credentials
        response.should redirect_to(root_url)
      end
    end

    context "when the user account isn't activated" do
      before(:each) do
        UserSession.stub!(:find).and_return(nil)
        UserSession.stub!(:new).and_return(@user_session = mock_model(UserSession, :save => false,
                                                                      :account_inactive? => true))
        @valid_credentials = {}
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

  context "Signing in (providing a logon form)" do
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

end
