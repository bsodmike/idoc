require 'spec_helper'

describe "display a documentation page" do
  before(:each) do
    assigns[:documentation_page] = mock_model(DocumentationPage, :title => "Test title", :content => "Test documentation")
    render 'documentation_pages/show'
  end
  it "should display the page title" do
    response.should contain("Test title")
  end
  
  it "should display the page content" do
    response.should contain("Test documentation")
  end
end