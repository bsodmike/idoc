require 'spec_helper'

describe UsersController, "creating a new user account" do
  context "When not identified as a user" do
    before(:each) do
      UserSession.stub!(:find).and_return(nil)
    end
    context "With valid user data" do
      before(:each) do
        @valid_data = {}
        User.stub!(:new).and_return(@user = mock_model(User, :save_without_session_maintenance => true))
      end

      it "should create a user with the provided data" do
        User.should_receive(:new)
        post :create, :user => @valid_data
      end

      it "should save the user without logging in" do
        @user.should_receive(:save_without_session_maintenance)
        post :create, :user => @valid_data
      end

      it "should redirect to the logon page" do
        post :create, :user => @valid_data
        response.should redirect_to(new_user_session_url)
      end

      it "should inform the user that the account was created successfully" do
        post :create, :user => @valid_data
        flash[:notice].should contain("Sign-up successful")
      end
    end

    context "With invalid user data" do
      before(:each) do
        @invalid_data = {}
        User.stub!(:new).and_return(@user = mock_model(User, :save_without_session_maintenance => false))

      end

      it "should create a user with the provided data" do
        User.should_receive(:new).with(@invalid_data)
        post :create, :user => @invalid_data
      end

      it "should attempt to save the user" do
        @user.should_receive(:save_without_session_maintenance)
        post :create, :user => @invalid_data
      end

      it "should request that the incorrect data be fixed" do
        post :create, :user => @invalid_data
        flash[:error].should contain("There were errors in the user data provided")
      end

      it "should provide the form for the user to try again" do
        post :create, :user => @invalid_data
        response.should render_template('users/new')
      end

      it "should provide the data for the form" do
        post :create, :user => @invalid_data
        assigns[:user].should == @user
      end
    end

  end

  context "When identified as a user" do
    before(:each) do
      UserSession.stub!(:find).and_return(mock_model(UserSession))
      @user_data = {}
    end

    it "should find the existing session" do
      UserSession.should_receive(:find)
      post :create, :user => @user_data
    end

    it "should not create a user" do
      User.should_not_receive(:new)
      post :create, :user => @user_data
    end

    it "should inform the user of the problem" do
      post :create, :user => @user_data
      flash[:error].should contain("You already have an account")
    end

    it "should return the user to the home page" do
      post :create, :user => @user_data
      response.should redirect_to(root_url)
    end
  end
end