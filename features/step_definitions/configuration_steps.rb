When /^I should see the title set to "([^\"]*)"$/ do |page_title|
  response.should have_selector("title") do |title|
    title.should contain(page_title)
  end
end

Given /^the site is using the document author list$/ do
  SiteConfig.update_or_create!(:use_document_author_list => true)
end