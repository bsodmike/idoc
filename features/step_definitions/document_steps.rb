Given /^there is no documentation$/ do
  DocumentationPage.destroy_all
end

Given /^I have created a page called "(.*)"$/ do |page_title|
  DocumentationPage.create("title" => page_title, "content" => "Some content")
end

Given /^I have created a page$/ do
  @title = "A page"
  @content = "More content"
  @documentation_page = DocumentationPage.create("title" => @title, "content" => @content)
end

Given /^I have created two document pages$/ do
  @title = "A page"
  @content = "Some content"
  @documentation_page = DocumentationPage.create("title" => @title, "content" => @content)
  @title2 = "Another page"
  @content2 = "Some more content"
  @documentation_page2 = DocumentationPage.create("title" => @title2, "content" => @content2)
end

Given /^I have created a subpage of "(.*)" called "(.*)" with position (\d)$/ do |parent_title, page_title, position|
  @parent = DocumentationPage.find_by_title(parent_title)
  DocumentationPage.create("title" => page_title, "parent_id" => @parent.id, "content" => "Test content", "position" => position)
end

When /^I enter a new page called "(.*)"$/ do |page_title|
  fill_in 'Title', :with => page_title
  fill_in 'Content', :with => "Some more content"
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

When /^I change the document title to "(.*)"$/ do |page_title|
  fill_in "Title", :with => page_title
end

When /^I set the parent to "(.*)"$/ do |page_title|
  select(page_title, :from => :parent)
end

When /^I set the parent to the other document$/ do
  select(@title2, :from => :parent)
end

When /^I set the parent to the existing document$/ do
  select(@title, :from => :parent)
end

When /^I set the position to (\d)$/ do |position|
  fill_in "Position", :with => position
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

Then /^I should see the position set to (\d)$/ do |position|
  response.should have_selector("input[type=text]", :name => "documentation_page[position]", :value => position.to_s)
end

Then /^I should see the documentation page called "(.*)"$/ do |page_title|
  response.should have_selector("h1") do |title|
    title.should contain(page_title)
  end
end

Then /^I should see the menu item for "(.*)"$/ do |page_title|
  response.should have_selector("ul.menu") do |menu|
    menu.should contain(page_title)
  end
end

Then /^I should see "(.*)" before "(.*)" underneath "(.*)"$/ do |subpage1, subpage2, page|
  response.should have_selector("ul.menu") do |menu|
    menu.should contain(page) do |menu_item|
      menu_item.should have_selector("li") do |item|
        item.should contain(subpage1)
      end
      menu_item.should have_selector("li + li") do |item|
        item.should contain(subpage2)
      end
    end
  end
end

Then /^I should see the menu item "(.*)" underneath "(.*)"$/ do |title_1, title_2|
  response.should have_selector("ul.menu") do |menu|
    menu.should have_selector("li") do |item|
      item.should contain(title_2)
      item.should have_selector("ul.menu") do |sub_menu|
        sub_menu.should have_selector("li") do |sub_item|
          sub_item.should contain(title_1)
        end
      end
    end
  end
end

Then /^I should see the menu list in a nested list$/ do
  response.should have_selector("ul.menu") do |menu|
    menu.should have_selector("li") do |item|
      item.should contain(@title2)
      item.should have_selector("ul.menu") do |nested_menu|
        nested_menu.should contain(@title)
      end
    end
  end
end

