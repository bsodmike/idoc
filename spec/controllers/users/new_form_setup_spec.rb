require 'spec_helper'

describe UsersController, "requesting a form to create a new user" do
  def perform_action
    get :new
  end
  it_should_behave_like "finding menu items"

  context "When not identified as a user" do
    before(:each) do
      UserSession.stub!(:find).and_return(nil)
      controller.stub!(:can?).and_return(true)
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
      controller.stub!(:can?).and_return(false)
    end

    it "should not create a user" do
      User.should_not_receive(:new)
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