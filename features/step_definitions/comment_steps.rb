When /^I enter a comment$/ do
  @comment_body = "Test comment"
  fill_in :comment, :with => @comment_body
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