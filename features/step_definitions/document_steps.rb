Given /^there is no documentation$/ do
  DocumentationPage.destroy_all
  DocumentationPage.reset_index
end

Given /^I have created a page called "(.*)"$/ do |page_title|
  DocumentationPage.create("title" => page_title, "content" => "Some content")
end

Given /^I have created a page$/ do
  @title = "A page"
  @content = "More content"
  @documentation_page = DocumentationPage.create("title" => @title, "content" => @content)
end

Given /^I have created a page called "(.*)" with position (\d)$/ do |page_title, position|
  DocumentationPage.create("title" => page_title, "content" => "Test content", "position" => position)
end

Given /^I have created two document pages$/ do
  @title = "A page"
  @content = "Some content"
  @documentation_page = DocumentationPage.create("title" => @title, "content" => @content)
  @title2 = "Another page"
  @content2 = "Some more content"
  @documentation_page2 = DocumentationPage.create("title" => @title2, "content" => @content2)
end

Given /^I have created a subpage of "(.*)" called "(.*)"$/ do |parent_title, page_title|
  @parent = DocumentationPage.find_by_title(parent_title)
  DocumentationPage.create("title" => page_title, "parent_id" => @parent.id, "content" => "Test content")
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

When /^I enter a title$/ do
  fill_in "Title", :with => "Testing"
end

When /^I enter content with bold and italic markdown elements$/ do
  fill_in "Content", :with => "Some **Bold** and *italic* text"
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

When /^I enter a youtube video$/ do
  @youtube_vid = '<object width="640" height="385"><param name="movie" value="http://www.youtube.com/v/RyMTjhel_oM&amp;hl=en_US&amp;fs=1&amp;" /><param name="allowFullScreen" value="true" /><param name="allowscriptaccess" value="always" /><embed src="http://www.youtube.com/v/RyMTjhel_oM&amp;hl=en_US&amp;fs=1&amp;" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="640" height="385"></embed></object>'
  fill_in "Content", :with => @youtube_vid
end

When /^I enter a vimeo video$/ do
  @vimeo_vid = '<object width="400" height="264"><param name="allowfullscreen" value="true" /><param name="allowscriptaccess" value="always" /><param name="movie" value="http://vimeo.com/moogaloop.swf?clip_id=9730308&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1" /><embed src="http://vimeo.com/moogaloop.swf?clip_id=9730308&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1" type="application/x-shockwave-flash" allowfullscreen="true" allowscriptaccess="always" width="400" height="264"></embed></object><p><a href="http://vimeo.com/9730308">projection animation test</a> from <a href="http://vimeo.com/reanimatr">reanimatr</a> on <a href="http://vimeo.com">Vimeo</a>.</p>'
  fill_in "Content", :with => @vimeo_vid
end

When /^I enter a non youtube video$/ do
  @non_youtube_vid = 'rad video <object width="640" height="385"><param name="movie" value="http://www.yawntube.com/v/RyMTjhel_oM&amp;hl=en_US&amp;fs=1&amp;" /><param name="allowFullScreen" value="true" /><param name="allowscriptaccess" value="always" /><embed src="http://www.yawntube.com/v/RyMTjhel_oM&amp;hl=en_US&amp;fs=1&amp;" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="640" height="385"></embed></object>'
  fill_in "Content", :with => @non_youtube_vid
end

When /^I attempt to delete "([^\"]*)"$/ do |page_title|
  visit path_to("the document page for \"#{page_title}\""), :delete
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

Then /^I should not see a button for "([^\"]*)"/ do |button_name|
  response.should_not have_selector('input[type=submit]', :value => button_name)
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

Then /^I should see "(.*)" before "([^"]*)" underneath "(.*)"$/ do |subpage1, subpage2, page|
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

Then /^I should see "(.*)" before "([^"]*)"$/ do |page1, page2|
  response.should have_selector("ul.menu") do |menu|
    menu.should have_selector("li") do |item|
      item.should contain(page1)
    end
    menu.should have_selector("li + li") do |item|
      item.should contain(page2)
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

Then /^I should see an? ([^ ]*) element in the content$/ do |element|
  response.should have_selector(".page_content") do |page|
    page.should have_selector(element)
  end
end

Then /^I should not see an? ([^ ]*) element in the content$/ do |element|

  response.should_not have_selector(element)
end


Then /I should see a youtube video$/ do
  response.should have_selector("object") do |obj|
    obj.should have_selector("param")
    obj.should have_selector("embed")
  end
end

Then /^I should see a vimeo video$/ do
  response.should have_selector("object") do |video|
    video.should have_selector("param")
    video.should have_selector("embed")
  end
end

When /^I set the parent of "([^\"]*)" to "([^\"]*)"$/ do |page, new_parent|
  p = DocumentationPage.find_by_title(page)
  select new_parent, :from => "documentation_tree_documentation_page_#{p.friendly_id}_parent_id"
end

When /^I set the position of "([^\"]*)" to (\d)$/ do |page, new_position|
  p = DocumentationPage.find_by_title(page)
  fill_in "documentation_tree_documentation_page_#{p.friendly_id}_position", :with => new_position
end