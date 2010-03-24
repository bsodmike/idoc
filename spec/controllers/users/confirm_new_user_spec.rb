require 'spec_helper'

describe UsersController, "Confirming a user account" do
  context "when unactivated" do

    before(:each) do
      User.stub!(:find_by_perishable_token).and_return(@user = mock_model(User, :activate! => true))
      @perishable_token = "1234"
    end
    it "should find a user by the activation token" do
      User.should_receive(:find_by_perishable_token).with(@perishable_token)
      get :confirm, :activation_token => @perishable_token
    end

    it "should activate the user" do
      @user.should_receive(:activate!)
      get :confirm, :activation_token => @perishable_token
    end

    it "should inform the user that activation was successful" do
      get :confirm, :activation_token => @perishable_token
      flash[:notice].should contain("Account activated")
    end

    it "should redirect the user to the account login page" do
      get :confirm, :activation_token => @perishable_token
      response.should redirect_to(new_user_session_url)
    end
  end
end
