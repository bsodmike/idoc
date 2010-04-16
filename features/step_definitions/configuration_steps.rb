When /^I should see the title set to "([^\"]*)"$/ do |page_title|
  response.should have_selector("title") do |title|
    title.should contain(page_title)
  end
end