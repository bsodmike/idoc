Given /I am not identified/ do
  visit path_to("the user session page"), :delete
end

Given /^I have created an account$/ do
  visit path_to("the new account page")
  When "I enter the required account details"
  click_button "Register"
end

Given /^I have activated my account$/ do
  Then 'I should receive an email'
  When 'I open the email'
  Then 'I should see "confirm" in the email body'
  When 'I follow "confirm" in the email'
  Then 'I should see "Account activated"'
end

Given /^I have not activated my account$/ do
  user = User.find_by_email(@email_address)
  user.active = false
  user.save!
end

Given /^I have not created an account$/ do
  User.destroy_all
end

Given /^I am identified$/ do
  Given "I have created an account"
  Given "I have activated my account"
  Given "I have logged in to my account"
end

Given /^I have logged in to my account$/ do
  visit path_to("the account logon page")
  fill_in :email, :with => @email_address
  fill_in :password, :with => "password"
  click_button "Log in"
  Then 'I should see "Logged in successfully"'
end

Given /^I am identified as an administrator$/ do
  Given "I have created an account"
  Given "I have activated my account"
  user = User.find_by_email(@email_address)
  user.admin = true
  user.save!
  Given "I have logged in to my account"
end

When /^I enter my account details$/ do
  fill_in :email, :with => @email_address
  fill_in :password, :with => "password"
end

When /^I enter the required account details$/ do
  @email_address = "test@test.com"
  fill_in :email, :with => @email_address
  fill_in :displayname, :with => "Tester"
  fill_in :password, :with => "password"
  fill_in "Password confirmation", :with => "password"
end