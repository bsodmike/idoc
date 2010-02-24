require 'spec_helper'

describe CommentsController, "Creating a new comment (form setup)" do
  it_should_behave_like "finding menu items"

  context "with an identified user" do
    before(:each) do
      @doc_page = mock_model(DocumentationPage, :comments => (@comments =  mock("comment_list")))
      @comments.stub!(:build).and_return(@comment = mock_model(Comment))
      DocumentationPage.should_receive(:find).with(@doc_page.id.to_s).and_return(@doc_page)
      UserSession.stub!(:find).and_return(mock_model(UserSession))
    end

    it "should find the documentation page parent" do
      get :new, :documentation_page_id => @doc_page.id
      assigns[:documentation_page].should == @doc_page
    end

    it "should set up the data for the form" do
      @comments.should_receive(:build)
      get :new, :documentation_page_id => @doc_page.id
      assigns[:comment].should == @comment
    end
  end

  context "without an identified user" do
    before(:each) do
      UserSession.stub!(:find).and_return(nil)
      @comment_data = {}
    end

    it "should check for a logged in user" do
      UserSession.should_receive(:find)
      get :new, :documentation_page_id => 1
    end

    it "should not find the document" do
      DocumentationPage.should_not_receive(:find)
      get :new, :documentation_page_id => 1
    end

    it "should inform the user of the problem" do
      get :new, :documentation_page_id => 1
      flash[:error] = "You must be logged on to add documentation"
    end

    it "should put the user on the account logon page" do
      get :new, :documentation_page_id => 1
      response.should redirect_to(new_user_session_url)
    end
  end
end

describe CommentsController, "Creating a new comment (comment construction)" do
  it_should_behave_like "finding menu items"

  context "with an identified user" do
    before(:each) do
      UserSession.stub!(:find).and_return(mock_model(UserSession))
    end
    context "with valid comment data" do
      before(:each) do
        @doc_page = mock_model(DocumentationPage, :comments => (@comments =  mock("comment_list")))
        @comments.stub!(:build).and_return(@comment = mock_model(Comment, :save => true))
        DocumentationPage.should_receive(:find).with(@doc_page.id.to_s).and_return(@doc_page)
        @valid_params = {}
      end

      it "should find the documentation page parent" do
        post :create, :documentation_page_id => @doc_page.id, :comment => @valid_params
        assigns[:documentation_page].should == @doc_page
      end

      it "should build a comment from the documentation comment list" do
        @comments.should_receive(:build).with(@valid_params)
        post :create, :documentation_page_id => @doc_page.id, :comment => @valid_params
      end

      it "should save the comment" do
        @comment.should_receive(:save)
        post :create, :documentation_page_id => @doc_page.id, :comment => @valid_params
      end

      it "should inform the user of their commenting success" do
        post :create, :documentation_page_id => @doc_page.id, :comment => @valid_params
        flash[:notice].should contain "Comment added"
      end

      it "should return the user to the documentation page" do
        post :create, :documentation_page_id => @doc_page.id, :comment => @valid_params
        response.should redirect_to(documentation_page_url(@doc_page))
      end
    end

    context "with invalid comment data" do
      before(:each) do
        @doc_page = mock_model(DocumentationPage, :comments => (@comments =  mock("comment_list")))
        @comments.stub!(:build).and_return(@comment = mock_model(Comment, :save => false))
        DocumentationPage.should_receive(:find).with(@doc_page.id.to_s).and_return(@doc_page)
        @invalid_params = {}
      end

      it "should find the documentation page parent" do
        post :create, :documentation_page_id => @doc_page.id, :comment => @invalid_params
        assigns[:documentation_page].should == @doc_page
      end

      it "should build a comment from the documentation comment list" do
        @comments.should_receive(:build).with(@invalid_params)
        post :create, :documentation_page_id => @doc_page.id, :comment => @invalid_params
      end

      it "should attempt to save the comment" do
        @comment.should_receive(:save)
        post :create, :documentation_page_id => @doc_page.id, :comment => @invalid_params
      end

      it "should inform the user of the failed save" do
        post :create, :documentation_page_id => @doc_page.id, :comment => @invalid_params
        flash[:error].should contain("Your comment could not be saved")
      end

      it "should provide the user with the form to correct their mistake" do
        post :create, :documentation_page_id => @doc_page.id, :comment => @invalid_params
        response.should render_template('comments/new')
      end
    end
  end

  context "without an identified user" do
    before(:each) do
      UserSession.stub!(:find).and_return(nil)
      @comment_data = {}
    end

    it "should check for a logged in user" do
      UserSession.should_receive(:find)
      post :create, :comment => @comment_data, :documentation_page_id => 1
    end

    it "should not find the document" do
      DocumentationPage.should_not_receive(:find)
      post :create, :comment => @comment_data, :documentation_page_id => 1
    end

    it "should inform the user of the problem" do
      post :create, :comment => @comment_data, :documentation_page_id => 1
      flash[:error] = "You must be logged on to add documentation"
    end

    it "should put the user on the account logon page" do
      post :create, :comment => @comment_data, :documentation_page_id => 1
      response.should redirect_to(new_user_session_url)
    end
  end
end
