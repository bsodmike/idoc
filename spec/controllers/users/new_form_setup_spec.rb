require 'spec_helper'

describe UsersController, "requesting a form to create a new user" do
  def perform_action
    get :new
  end
  it_should_behave_like "finding menu items"

  context "When not identified as a user" do
    before(:each) do
      UserSession.stub!(:find).and_return(nil)
    end
    it "should set up the data for a new user form" do
      User.should_receive(:new).and_return(user = mock_model(User).as_new_record)
      get :new
      assigns[:user].should == user
    end
  end

  context "When identified as a user" do
    before(:each) do
      UserSession.stub!(:find).and_return(mock_model(UserSession))
    end

    it "should find the existing session" do
      UserSession.should_receive(:find)
      get :new
    end

    it "should not create a user" do
      User.should_not_receive(:new)
      get :new
    end

    it "should inform the user of the problem" do
      get :new
      flash[:error].should contain("You already have an account")
    end

    it "should return the user to the home page" do
      get :new
      response.should redirect_to(root_url)
    end
  end
end