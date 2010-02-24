require 'spec_helper'

describe "display a documentation page anonymous browsing" do
  before(:each) do
    @documentation_page = mock_model(DocumentationPage, :title => "Test title", :content => "Test documentation", :comments => [])
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


describe "when the page has some comments" do
  before(:each) do
    @comment_time = Time.now
    @comment = mock_model(Comment, :body => 'Test comment', :created_at => @comment_time)
    @documentation_page = mock_model(DocumentationPage, :title => "Test title", :content => "Test documentation", :comments => [@comment])
    assigns[:documentation_page] = @documentation_page
    render 'documentation_pages/show'
  end

  it "should display the comment" do
    response.should have_selector(".comment") do |d|
      d.should contain(@comment.body)
    end
  end
end

describe "displaying a documentation page with a logged in user" do
  before(:each) do
    @documentation_page = mock_model(DocumentationPage, :title => "Test title", :content => "Test documentation", :comments => [])
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