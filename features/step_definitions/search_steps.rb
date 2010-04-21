When /^I enter "([^\"]*)" in the search field$/ do |search_text|
  fill_in 'search', :with => search_text
end
Given /^there is no search index$/ do
  FileUtils.rm_rf(DocumentationPage::SEARCH_INDEX)
end