require 'spec_helper'

describe DocumentationPagesController, "Searching documentation" do
  before(:each) do
    @results = [mock_model(DocumentationPage), mock_model(DocumentationPage)]
    DocumentationPage.stub!(:search).and_return(@results)
    @results.each do |p|
      DocumentationPage.stub!(:find).with(p.id).and_return(p)
    end
    
    @search_term = "test search"
  end

  def perform_action
    get :search, :search => @search_term
  end
  
  it_should_behave_like "finding menu items"

  it "should get the documentation page index" do
    DocumentationPage.should_receive(:search).with(@search_term)
    perform_action
  end

  it "should store the query for use in the view" do
    perform_action
    assigns[:query].should == @search_term
  end
end