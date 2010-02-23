require 'spec_helper'

describe "display a documentation page anonymous browsing" do
  before(:each) do
    @documentation_page = mock_model(DocumentationPage, :title => "Test title", :content => "Test documentation")
    assigns[:documentation_page] = @documentation_page
    render 'documentation_pages/show'
  end
  it "should display the page title" do
    response.should contain("Test title")
  end

  it "should display the page content" do
    response.should contain("Test documentation")
  end

  it "should not provide a link to add a new comment" do
    response.should_not have_selector("a", :href => new_documentation_page_comment_path(@documentation_page))
  end

  it "should inform the user that they need to sign in to add comments" do
    response.should contain("You need to log in to add a comment")
  end
end

describe "displaying a documentation page with a logged in user" do
  before(:each) do
    @documentation_page = mock_model(DocumentationPage, :title => "Test title", :content => "Test documentation")
    assigns[:documentation_page] = @documentation_page
    assigns[:current_user] = mock_model(User, :email => "test@test.com")
    render 'documentation_pages/show'
  end

  it "should provide a link to add a new comment" do
    response.should have_selector("a", :href => new_documentation_page_comment_path(@documentation_page)) do |f|
      f.should contain("Add comment")
    end
  end
end