Given /I am not identified/ do
  visit path_to("the user session page"), :delete
end

When /^I enter the required account details$/ do
  @email_address = "test@test.com"
  fill_in :email, :with => @email_address
  fill_in :password, :with => "password"
  fill_in "Password confirmation", :with => "password"
end

Given /^I have created an account$/ do
  visit path_to("the new account page")
  When "I enter the required account details"
  click_button "Register"
end