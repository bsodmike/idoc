require "spec_helper"

describe UserSignup do
  include ActionController::UrlWriter


  before(:each) do
    @host = "test.host"
    ActionMailer::Base.default_url_options[:host] = @host
    @user = mock_model(User, :email => "test@test.com", :perishable_token => "1234")
    @email = UserSignup.create_confirmation_email(@user)
  end

  it "should deliver the email to the provided user" do
    @email.should deliver_to(@user.email)
  end

  it "should have the account confirmation url" do
    @email.should have_selector("a", :href => confirm_users_url(:activation_token => @user.perishable_token, :host => @host)) do |link|
      link.should contain("confirm")
    end
  end

end