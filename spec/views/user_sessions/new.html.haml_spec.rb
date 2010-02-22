require 'spec_helper'

describe "the account log on form" do
  before(:each) do
    assigns[:user_session] = mock_model(UserSession, :null_object => true).as_new_record
    render 'user_sessions/new'
  end

  it "should present a form for logging onto iDoc" do
    response.should have_selector("form[method=post]") do |f|
      f.should have_selector("input[type=submit]", :value => "Log in")
    end
  end

  it "should provide a text box for the user's email address" do
    response.should have_selector("form") do |f|
      f.should have_selector("input[type=text]", :name => "user_session[email]")
    end
  end

  it "should provide a password box for the user's password" do
    response.should have_selector("form") do |f|
      f.should have_selector("input[type=password]", :name => "user_session[password]")
    end
  end

end
