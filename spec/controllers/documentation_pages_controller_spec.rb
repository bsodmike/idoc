require 'spec_helper'

describe DocumentationPagesController, "providing a blank documentation page" do
  before(:each) do
    @failed_logon_error_message = "You must be logged on to add documentation"
    @doc_page = mock_model(DocumentationPage, :save => true)
    DocumentationPage.stub!(:new).and_return(@doc_page)
  end
  def perform_action
    get :new
  end
  it_should_behave_like "finding menu items"
  it_should_behave_like "requires user logon"

  it "should set up the data for a new page" do
    DocumentationPage.should_receive(:new).and_return(doc_page = mock_model(DocumentationPage))
    get :new
    assigns(:documentation_page).should == doc_page
  end
end

describe DocumentationPagesController, "creating a new page" do
  before(:each) do
    @failed_logon_error_message = "You must be logged on to add documentation"
    @doc_page = mock_model(DocumentationPage, :save => true)
    DocumentationPage.stub!(:new).and_return(@doc_page)
    @data = {}
  end
  def perform_action
    post :create, :documentation_page => {}
  end
  it_should_behave_like "finding menu items"
  it_should_behave_like "requires user logon"

  it "should create the page" do
    DocumentationPage.should_receive(:new).with(@data)
    post :create, :documentation_page => @data
  end

  it "should attempt to save the page" do
    @doc_page.should_receive(:save)
    post :create, :documentation_page => @data
  end

  context "with valid data" do
    before(:each) do
      @doc_page.stub!(:save).and_return(true)
      @valid_data = {}
    end

    it "should redirect to the new documentation page" do
      post :create, :documentation_page => @valid_data
      response.should redirect_to(documentation_page_url(@doc_page))
    end
  end

  context "with invalid data" do
    before(:each) do
      @doc_page.stub!(:save).and_return(false)
      @invalid_data = {}
    end

    it "should inform the user of the problem" do
      post :create, :documentation_page => @invalid_data
      flash[:error].should contain("Errors existed in the documentation page")
    end

    it "should provide the user with the form to correct the mistake" do
      post :create, :documentation_page => @invalid_data
      response.should render_template('documentation_pages/new')
    end
  end
end

describe DocumentationPagesController, "displaying a documentation page" do
  def perform_action
    get :show, :id => @doc_page.id
  end
  it_should_behave_like "finding menu items"

  before(:each) do
    UserSession.stub!(:find).and_return(nil)
    @doc_page = mock_model(DocumentationPage)
    DocumentationPage.stub!(:find).and_return(@doc_page)
  end
  it "should find the documentation page" do
    DocumentationPage.should_receive(:find).with(@doc_page.id.to_s)
    get :show, :id => @doc_page.id
    assigns(:documentation_page).should == @doc_page
  end

  context "with an identified user" do
    it "should find the identified user" do
      UserSession.should_receive(:find).and_return(user_session = mock_model(UserSession))
      user_session.should_receive(:record).and_return(user = mock_model(User))
      get :show, :id => @doc_page.id
      assigns[:current_user].should == user
    end
  end
end

describe DocumentationPagesController, "editing an existing page (providing the form)" do
  before(:each) do
    @failed_logon_error_message = "You must be logged on to edit documentation"
    @doc_page = mock_model(DocumentationPage)
    @all_pages = Array.new(4) {mock_model(DocumentationPage)}
    @all_pages << @doc_page
    DocumentationPage.stub!(:find).and_return(@doc_page)
    DocumentationPage.stub!(:find).with(:all).and_return(@all_pages)
  end
  def perform_action
    get :edit, :id => @doc_page.id
  end
  it_should_behave_like "finding menu items"
  it_should_behave_like "requires user logon"

  it "should find the documentation page" do
    DocumentationPage.should_receive(:find).with(@doc_page.id.to_s)
    get :edit, :id => @doc_page.id
    assigns[:documentation_page].should == @doc_page
  end

  it "should find all the documentation pages" do
    DocumentationPage.should_receive(:find).with(:all).and_return(@all_pages)
    get :edit, :id => @doc_page.id
  end

  it "should remove the current page from it's all_documents output" do
    get :edit, :id => @doc_page.id
    assigns[:all_documents].should == (@all_pages - [@doc_page])
  end
end

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
