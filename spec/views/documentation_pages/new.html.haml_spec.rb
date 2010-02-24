require 'spec_helper'

describe "create a new documentation page" do
  before(:each) do
    @errors = mock("Errors", :empty? => true)
    assigns[:documentation_page] = mock_model(DocumentationPage, :null_object => true, :errors => @errors).as_new_record
    render 'documentation_pages/new'
  end

  it "should give a form for entering a new page" do
    response.should have_selector("form[method=post]", :action => documentation_pages_path) do |form|
      form.should have_selector("input[type=submit]")
    end
  end

  it "should provide a way to enter a title" do
    response.should have_selector("form") do |form|
      form.should have_selector("input[type=text]", :name => 'documentation_page[title]')
    end
  end

  it "should provide a way to enter to enter multiple lines of content" do
    response.should have_selector("form") do |form|
      form.should have_selector("textarea", :name => 'documentation_page[content]')
    end
  end

  it "should not display an error box" do
    response.should_not have_selector(".errors")
  end
end

describe "displaying a new documentation page form with errors" do
  before(:each) do
    @errors = mock("Errors", :empty? => false)
    assigns[:documentation_page] = mock_model(DocumentationPage, :null_object => true, :errors => @errors).as_new_record
    template.stub!(:error_messages_for).and_return("Test error")
    render 'documentation_pages/new'
  end

  it "should display an error" do
    response.should have_selector(".errors") do |d|
      d.should contain("Test error")
    end
  end
end
