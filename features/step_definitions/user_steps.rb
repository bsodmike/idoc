Given /I am not identified/ do
  visit path_to("the user session page"), :delete
end

When /^I enter the required account details$/ do
  @email_address = "test@test.com"
  fill_in :email, :with => @email_address
  fill_in :password, :with => "password"
  fill_in "Password confirmation", :with => "password"
end

Then /^I should have a new email$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^I have created an account$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I follow 'confirm' in the email$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see 'Account activated'$/ do
  pending # express the regexp above with the code you wish you had
end
