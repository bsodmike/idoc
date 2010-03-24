require 'spec_helper'

describe DocumentationPagesController, "creating a new page" do
  before(:each) do
    @failed_logon_error_message = "You must be logged on to add documentation"
    @doc_page = mock_model(DocumentationPage, :save => true)
    DocumentationPage.stub!(:new).and_return(@doc_page)
  end
  def perform_action
    post :create, :documentation_page => {}
  end
  it_should_behave_like "finding menu items"
  it_should_behave_like "requires user logon"

  it "should create the page" do
    DocumentationPage.should_receive(:new).with({})
    perform_action
  end

  it "should attempt to save the page" do
    @doc_page.should_receive(:save)
    perform_action
  end

  context "with valid data" do
    before(:each) do
      @doc_page.stub!(:save).and_return(true)
    end

    it "should redirect to the new documentation page" do
      perform_action
      response.should redirect_to(documentation_page_url(@doc_page))
    end

    it "should inform the user of the successful creation" do
      perform_action
      flash[:notice].should contain("Page added")
    end
  end

  context "with invalid data" do
    before(:each) do
      @doc_page.stub!(:save).and_return(false)
      create_all_pages_array(@doc_page)
    end

    it "should inform the user of the problem" do
      perform_action
      flash[:error].should contain("Errors existed in the documentation page")
    end

    it "should provide the user with the form to correct the mistake" do
      perform_action
      response.should render_template('documentation_pages/new')
    end

    it "should find all the documentation pages" do
      perform_action
      assigns[:all_documents].should == @all_pages - [@doc_pages]
    end
  end
end