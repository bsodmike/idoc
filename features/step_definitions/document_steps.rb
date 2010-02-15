Given /^there is no documentation$/ do
  DocumentationPage.destroy_all
end

When /^I enter documentation$/ do
  fill_in 'Title', :with => "Testing"
  fill_in "Content", :with => "Test documentation"
end

Then /^I should see the documentation page$/ do
  response.should contain("Testing")
  response.should contain("Test documentation")
end

Then /^I should see the menu item for the page$/ do
  response.should have_selector("ul.menu") do |menu|
    menu.should contain("Testing")
  end
end

Given /^I have created a page$/ do
  pending # express the regexp above with the code you wish you had
end
