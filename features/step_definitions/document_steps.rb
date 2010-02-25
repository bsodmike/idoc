Given /^there is no documentation$/ do
  DocumentationPage.destroy_all
end

When /^I enter documentation$/ do
  @title = "Testing"
  @content = "Test documentation"
  fill_in 'Title', :with => @title
  fill_in "Content", :with => @content
end

When /^I enter documentation without a title$/ do
  @content = "Test documentation"
  fill_in "Content", :with => @content
end

When /^I enter documentation without page content$/ do
  @title = "Testing"
  fill_in "Title", :with => @title
end

When /^I remove the document title$/ do
  @title = ""
  fill_in "Title", :with => @title
end

When /^I change the document title$/ do
  @title = "New testing"
  fill_in "Title", :with => @title
end

Then /^I should see the documentation page$/ do
  response.should contain(@title)
  response.should contain(@content)
end

Then /^I should see the page body$/ do
  response.should contain(@content)
end

Then /^I should see the menu item for the page$/ do
  response.should have_selector("ul.menu") do |menu|
    menu.should contain(@title)
  end
end

Then /^I should see the new title$/ do
  response.should contain(@title)
end

Given /^I have created a page$/ do
  @title = "A page"
  @content = "More content"
  @documentation_page = DocumentationPage.create("title" => @title, "content" => @content)
end
