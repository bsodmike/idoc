require 'spec_helper'

describe CommentsController, "Creating a new comment (comment construction)" do
  before(:each) do
    setup_create_comment
  end
  def perform_action
    post :create, :documentation_page_id => @doc_page.id, :comment => {}
  end
  it_should_behave_like "finding menu items"
  it_should_behave_like "deny access to area with 403 and user login"

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

    it "should build a comment from the documentation comment list" do
      perform_action
      assigns[:comment].should == @comment
    end

    it "should set the comment user to the current user" do
      @comment.should_receive(:user=).with(@user)
      perform_action
    end

    it "should attempt to save the comment" do
      @comment.should_receive(:save!)
      perform_action
    end

    context "with valid comment data" do
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
        @comment.stub!(:save!).and_raise(ActiveRecord::RecordNotSaved)
      end

      it "should inform the user of the failed save" do
        flash.should_receive(:now).and_return(h = mock(Hash))
        h.should_receive(:[]=).with(:error, "Your comment could not be saved")
        perform_action
      end

      it "should provide the user with the form to correct their mistake" do
        perform_action
        response.should render_template('comments/new')
      end
    end
  end
end