require 'spec_helper'

describe CommentsController, "Creating a new comment (form setup)" do
  before(:each) do
    setup_new_comment
  end
  def perform_action
    get :new, :documentation_page_id => @doc_page.id
  end
  it_should_behave_like "finding menu items"

  it "should check the user can create comments" do
    controller.should_receive(:can?).with(:create, Comment)
    perform_action
  end

  context "User can create comments" do
    before(:each) do
      controller.stub!(:can?).and_return(true)
    end

    it "should find the documentation page parent" do
      perform_action
      assigns[:documentation_page].should == @doc_page
    end

    it "should set up the data for the form" do
      perform_action
      assigns[:comment].should == @comment
    end
  end

  context "User cannot create comments" do
    before(:each) do
      controller.stub!(:can?).and_return(false)
    end

    it "should inform the user they must be logged in" do
      perform_action
      flash[:error].should contain("You must be logged in to post comments")
    end

    it "should redirect the user to the login page" do
      perform_action
      response.should redirect_to(new_user_session_url)
    end
  end
end