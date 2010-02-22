require 'spec_helper'

describe "Creating a new user" do
  before(:each) do
    assigns[:user] = mock_model(User, :null_object => true).as_new_record
    render 'users/new'
  end

  it "should provide a form for creating a user" do
    response.should have_selector("form[method=post]", :action => users_path) do |f|
      f.should have_selector("input[type=submit]", :value => "Register")
    end
  end

  it "should require an email address" do
    response.should have_selector("form") do |f|
      f.should have_selector("input[type=text]", :name => 'user[email]')
    end

  end

  it "should require a password and password confirmation" do
    response.should have_selector("form") do |f|
      f.should have_selector("input[type=password]", :name => 'user[password]')
      f.should have_selector("input[type=password]", :name => 'user[password_confirmation]')
    end
  end
end
