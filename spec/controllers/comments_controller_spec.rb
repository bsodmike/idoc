require 'spec_helper'

describe CommentsController, "Creating a new comment (form setup)" do
  before(:each) do
    @failed_logon_error_message = "You must be logged on to add a comment"
    @doc_page = mock_model(DocumentationPage, :comments => (@comments =  mock("comment_list")))
    @comments.stub!(:build).and_return(@comment = mock_model(Comment))
    @comment.stub!(:user=)
    DocumentationPage.stub!(:find).and_return(@doc_page)
    controller.stub!(:current_user).and_return(@user = mock_model(User))
  end
  def perform_action
    get :new, :documentation_page_id => @doc_page.id
  end
  it_should_behave_like "finding menu items"
  it_should_behave_like "requires user logon"

  it "should find the documentation page parent" do
    DocumentationPage.should_receive(:find).with(@doc_page.id.to_s)
    get :new, :documentation_page_id => @doc_page.id
    assigns[:documentation_page].should == @doc_page
  end

  it "should set up the data for the form" do
    @comments.should_receive(:build)
    get :new, :documentation_page_id => @doc_page.id
    assigns[:comment].should == @comment
  end
end

describe CommentsController, "Creating a new comment (comment construction)" do
  before(:each) do
    @failed_logon_error_message = "You must be logged on to add a comment"
    @doc_page = mock_model(DocumentationPage, :comments => (@comments =  mock("comment_list")))
    @comments.stub!(:build).and_return(@comment = mock_model(Comment, :save => true))
    @comment.stub!(:user=)
    DocumentationPage.stub!(:find).and_return(@doc_page)
    @params = {}
    controller.stub!(:current_user).and_return(@user = mock_model(User))
  end
  def perform_action
    post :create, :documentation_page_id => @doc_page.id, :comment => {}
  end
  it_should_behave_like "finding menu items"
  it_should_behave_like "requires user logon"

  it "should find the documentation page parent" do
    DocumentationPage.should_receive(:find)
    post :create, :documentation_page_id => @doc_page.id, :comment => @params
    assigns[:documentation_page].should == @doc_page
  end

  it "should build a comment from the documentation comment list" do
    @comments.should_receive(:build).with(@params)
    post :create, :documentation_page_id => @doc_page.id, :comment => @params
  end

  it "should set the comment user to the current user" do
    @comment.should_receive(:user=).with(@user)
    post :create, :documentation_page_id => @doc_page.id, :comment => @params
  end

  it "should attempt to save the comment" do
    @comment.should_receive(:save)
    post :create, :documentation_page_id => @doc_page.id, :comment => @params
  end

  context "with valid comment data" do
    before(:each) do
      @comment.stub!(:save).and_return(true)
      @valid_params = {}
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
      @comment.stub!(:save).and_return(false)
      @invalid_params = {}
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
