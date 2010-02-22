require "spec_helper"

describe User do

  before(:each) do
    @valid_attributes = {:email => "test@test.com", :password => "password", :password_confirmation => "password"}
  end

  it "should send a confirmation email after being created" do
    @user = User.new(@valid_attributes)
    UserSignup.should_receive(:deliver_confirmation_email).with(@user)
    @user.save
  end
end