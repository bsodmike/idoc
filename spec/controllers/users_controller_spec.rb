require 'spec_helper'

describe UsersController, "requesting a form to create a new user" do
  it_should_behave_like "finding menu items"

  context "When not identified as a user" do
    it "should set up the data for a new user form" do
      User.should_receive(:new).and_return(user = mock_model(User).as_new_record)
      get :new
      assigns[:user].should == user
    end
  end

end
