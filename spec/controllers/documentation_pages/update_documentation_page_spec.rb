require 'spec_helper'

describe DocumentationPagesController, "editing an existing page (performing the update)" do
  before(:each) do
    @failed_logon_error_message = "You must be logged on to edit documentation"
    @doc_page = mock_model(DocumentationPage, :save => true)
    @doc_page.stub!(:update_attributes)
    DocumentationPage.stub!(:find).and_return(@doc_page)
    @valid_params = {}
  end
  def perform_action
    post :update, :id => @doc_page.id, :documentation_page => {}
  end
  it_should_behave_like "finding menu items"
  it_should_behave_like "requires user logon"

  it "should find the documentation page" do
    DocumentationPage.should_receive(:find).with(@doc_page.id.to_s)
    post :update, :id => @doc_page.id, :documentation_page => @valid_params
    assigns[:documentation_page].should == @doc_page
  end

  it "should update the documentation page's attributes and then save" do
    @doc_page.should_receive(:update_attributes).once.ordered.with(@valid_params)
    @doc_page.should_receive(:save).once.ordered
    post :update, :id => @doc_page.id, :documentation_page => @valid_params
  end

  context "successful update" do
    it "should inform the user of the successful update" do
      post :update, :id => @doc_page.id, :documentation_page => @valid_params
      flash[:notice].should contain("Page successfully updated")
    end

    it "should return the user to the documentation page" do
      post :update, :id => @doc_page.id, :documentation_page => @valid_params
      response.should redirect_to(documentation_page_url(@doc_page))
    end
  end

  context "unsuccessful update" do
    before(:each) do
      @doc_page.stub!(:save).and_return(false)
      @invalid_params = {}
      @all_pages = Array.new(4) {mock_model(DocumentationPage)}
      @all_pages << @doc_page
      DocumentationPage.stub!(:find).with(:all).and_return(@all_pages)
    end
    it "should inform the user of an error occuring" do
      post :update, :id => @doc_page.id, :documentation_page => @invalid_params
      flash[:error].should contain("Errors occured during page update")
    end

    it "should find all the documentation pages" do
      DocumentationPage.should_receive(:find).with(:all).and_return(@all_pages)
      get :edit, :id => @doc_page.id
    end

    it "should remove the current page from it's all_documents output" do
      get :edit, :id => @doc_page.id
      assigns[:all_documents].should == (@all_pages - [@doc_page])
    end

    it "should provide the user with the update form again" do
      post :update, :id => @doc_page.id, :documentation_page => @invalid_params
      response.should render_template("documentation_pages/edit")
    end
  end
end
