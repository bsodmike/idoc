require 'spec_helper'

describe CommentsController, "Creating a new comment (comment construction)" do
  before(:each) do
    setup_create_comment
  end
  def perform_action
    post :create, :documentation_page_id => @doc_page.id, :comment => {}
  end
  it_should_behave_like "finding menu items"
  it_should_behave_like "requires user logon"

  it "should find the documentation page parent" do
    perform_action
    assigns[:documentation_page].should == @doc_page
  end

  it "should build a comment from the documentation comment list" do
    perform_action
    assigns[:comment].should == @comment
  end

  it "should set the comment user to the current user" do
    @comment.should_receive(:user=).with(@user)
    perform_action
  end

  it "should attempt to save the comment" do
    @comment.should_receive(:save)
    perform_action
  end

  context "with valid comment data" do
    before(:each) do
      @comment.stub!(:save).and_return(true)
    end

    it "should inform the user of their commenting success" do
      perform_action
      flash[:notice].should contain "Comment added"
    end

    it "should return the user to the documentation page" do
      perform_action
      response.should redirect_to(documentation_page_url(@doc_page))
    end
  end

  context "with invalid comment data" do
    before(:each) do
      @comment.stub!(:save).and_return(false)
    end

    it "should inform the user of the failed save" do
      perform_action
      flash[:error].should contain("Your comment could not be saved")
    end

    it "should provide the user with the form to correct their mistake" do
      perform_action
      response.should render_template('comments/new')
    end
  end
end