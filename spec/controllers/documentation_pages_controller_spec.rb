require 'spec_helper'

describe DocumentationPagesController, "providing a blank documentation page" do
  it_should_behave_like "finding menu items"

  context "with an identified user" do
    before(:each) do
      @doc_page = mock_model(DocumentationPage, :save => true)
      DocumentationPage.stub!(:new).and_return(@doc_page)
      UserSession.stub(:find).and_return(@user_session = mock_model(UserSession))
    end

    it "should check for a logged in user" do
      UserSession.should_receive(:find)
      get :new
    end
    
    it "should set up the data for a new page" do
      DocumentationPage.should_receive(:new).and_return(doc_page = mock_model(DocumentationPage))
      get :new
      assigns(:documentation_page).should == doc_page
    end
  end

  context "without an identified user" do
    before(:each) do
      UserSession.stub!(:find).and_return(nil)
    end

    it "should check for a logged in user" do
      UserSession.should_receive(:find)
      get :new
    end

    it "should not create a document" do
      DocumentationPage.should_not_receive(:new)
      get :new
    end

    it "should inform the user of the problem" do
      get :new
      flash[:error] = "You must be logged on to add documentation"
    end

    it "should put the user on the account logon page" do
      get :new
      response.should redirect_to(new_user_session_url)
    end
  end
end

describe DocumentationPagesController, "creating a new page" do

  context "with an identified user" do
    before(:each) do
      @doc_page = mock_model(DocumentationPage, :save => true)
      DocumentationPage.stub!(:new).and_return(@doc_page)
      UserSession.stub(:find).and_return(@user_session = mock_model(UserSession))
    end

    it "should check for a logged in user" do
      UserSession.should_receive(:find)
      post :create, :documentation_page => {}
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
  context "without an identified user" do
    before(:each) do
      UserSession.stub!(:find).and_return(nil)
      @page_data = {}
    end

    it "should check for a logged in user" do
      UserSession.should_receive(:find)
      post :create, :documentation_page => @page_data
    end

    it "should not create a document" do
      DocumentationPage.should_not_receive(:new)
      post :create, :documentation_page => @page_data
    end

    it "should inform the user of the problem" do
      post :create, :documentation_page => @page_data
      flash[:error] = "You must be logged on to add documentation"
    end

    it "should put the user on the account logon page" do
      get :new
      response.should redirect_to(new_user_session_url)
    end
  end
end

describe DocumentationPagesController, "displaying a documentation page" do
  it_should_behave_like "finding menu items"

  it "should find the documentation page" do
    doc_page = mock_model(DocumentationPage)
    DocumentationPage.should_receive(:find).with(doc_page.id.to_s).and_return(doc_page)
    get :show, :id => doc_page.id
    assigns(:documentation_page).should == doc_page
  end
end
