require 'spec_helper'

describe "creating a new comment for a documentation page with no errors" do
  before(:each) do
    @errors = mock("Errors", :empty? => true)
    @documentation_page = mock_model(DocumentationPage, :null_object => true)
    assigns[:documentation_page] = @documentation_page 
    assigns[:comment] = mock_model(Comment, :null_object => true, :errors => @errors).as_new_record
    render 'comments/new'
  end

  it "should provide a form for entering the comment" do
    response.should have_selector("form[method=post]", :action => documentation_page_comments_path(@documentation_page)) do |f|
      f.should have_selector("input[type=submit]", :value => "Submit comment")
    end
  end

  it "should provide a multi-line text box for entering comment text" do
    response.should have_selector("form") do |f|
      f.should have_selector("textarea", :name => "comment[body]")
    end
  end

  it "should not display an error box" do
    response.should_not have_selector(".errors")
  end
end

describe "displaying a new comment for a documentation page with errors" do
  before(:each) do
    @errors = mock("Errors", :empty? => false)
    @documentation_page = mock_model(DocumentationPage, :null_object => true)
    assigns[:documentation_page] = @documentation_page
    assigns[:comment] = mock_model(Comment, :null_object => true, :errors => @errors).as_new_record
    template.stub!(:error_messages_for).and_return("Test error")
    render 'comments/new'
  end

  it "should display the error messages" do
    response.should have_selector(".errors") do |d|
      d.should contain("Test error")
    end
  end
end