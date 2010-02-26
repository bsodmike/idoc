require 'spec_helper'

describe "update an existing documentation page" do
  before(:each) do
    @errors = mock("Errors", :empty? => true)
    assigns[:documentation_page] = @doc_page = mock_model(DocumentationPage, :null_object => true, :errors => @errors)
    assigns[:all_documents] = [mock_model(DocumentationPage, :title => "Testing"),
                               mock_model(DocumentationPage, :title => "Another Test")]
    render 'documentation_pages/edit'
  end

  it "should give a form for editing the page page" do
    response.should have_selector("form[method=post]", :action => documentation_page_path(@doc_page)) do |form|
      form.should have_selector("input[type=hidden]", :name => "_method", :value => "put")
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

  it "should provide a list of all the parents" do
    response.should have_selector("select", :name => 'documentation_page[parent_id]') do |s|
      s.should have_selector("option") do |o|
        o.should contain("Testing")
      end
      s.should have_selector("option") do |o|
        o.should contain("Another Test")
      end
    end
  end

  it "should not display an error box" do
    response.should_not have_selector(".errors")
  end
end

describe "updating an existing documentation page form with errors" do
  before(:each) do
    @errors = mock("Errors", :empty? => false)
    assigns[:documentation_page] = mock_model(DocumentationPage, :null_object => true, :errors => @errors)
    assigns[:all_documents] = []
    template.stub!(:error_messages_for).and_return("Test error")
    render 'documentation_pages/edit'
  end

  it "should display an error" do
    response.should have_selector(".errors") do |d|
      d.should contain("Test error")
    end
  end
end
