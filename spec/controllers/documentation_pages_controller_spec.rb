require 'spec_helper'

describe DocumentationPagesController, "creating a new page" do
  
  it "should set up the data for a new page" do
    DocumentationPage.should_receive(:new).and_return(doc_page = mock_model(DocumentationPage))
    get :new
    assigns(:documentation_page).should == doc_page
  end

  context "with valid data" do
    before(:each) do
      @doc_page = mock_model(DocumentationPage, :save => true)
      DocumentationPage.stub!(:new).and_return(@doc_page)
      @valid_data = {}
    end
    
    it "should create the page" do
      DocumentationPage.should_receive(:new).with(@valid_data)
      post :create, :documentation_page => @valid_data
    end
    
    it "should save the page" do
      @doc_page.should_receive(:save)
      post :create, :documentation_page => @valid_data
    end
    
    it "should redirect to the new documentation page" do
      post :create, :documentation_page => @valid_data
      response.should redirect_to(documentation_page_url(@doc_page))
    end
  end
  
  context "with invalid data" do
    before(:each) do
      @doc_page = mock_model(DocumentationPage, :save => false)
      DocumentationPage.stub!(:new).and_return(@doc_page)
      @invalid_data = {}
    end
  end
end

describe DocumentationPagesController, "displaying a documentation page" do
  it "should find the documentation page" do
    doc_page = mock_model(DocumentationPage)
    DocumentationPage.should_receive(:find).with(doc_page.id.to_s).and_return(doc_page)
    get :show, :id => doc_page.id
    assigns(:documentation_page).should == doc_page
  end
end
