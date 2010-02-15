require 'spec_helper'

describe "create a new documentation page" do
  before(:each) do
    assigns[:documentation_page] = mock_model(DocumentationPage, :null_object => true).as_new_record
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
end
