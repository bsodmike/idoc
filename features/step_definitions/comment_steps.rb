Given /^I have added a comment on "([^\"]*)"$/ do |documentation_page|
  visit path_to("the document page for \"#{documentation_page}\"")
  When "I enter a comment"
  When "I press \"Submit comment\""
end

Then /^I should not see a comment$/ do
  Then "I should not see \"#{@comment_body}\""
end

When /^I enter a comment$/ do
  @comment_body = "Test comment"
  fill_in "comment_body", :with => @comment_body
end

When /^I enter a comment without a body$/ do
  #No definition here yet as the only thing a comment has is a body
end

Then /^I should see my comment$/ do
  Then "I should see \"#{@comment_body}\""
end

Then /^I should see my display name$/ do
  Then "I should see \"Tester\""  
end