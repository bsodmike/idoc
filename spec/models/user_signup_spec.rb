require "spec_helper"

describe UserSignup do

  before(:each) do
    @user = mock_model(User, :email => "test@test.com")
    @email = UserSignup.create_confirmation_email(@user)
  end

  it "should deliver the email to the provided user" do
    @email.should deliver_to(@user.email)
  end

end