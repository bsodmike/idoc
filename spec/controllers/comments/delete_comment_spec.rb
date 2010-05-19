require 'spec_helper'

describe CommentsController, "Deleting a comment" do
  before(:each) do
    @comment = mock_model(Comment, :destroy => true)
    @doc_page = mock_model(DocumentationPage)
    @doc_page.stub_chain(:comments, :find).and_return(@comment)
    DocumentationPage.stub!(:find).and_return(@doc_page)
  end

  def perform_action
    delete :destroy, :documentation_page_id => @doc_page.id, :id => @comment.id
  end

  it "should find the documentation page" do
    DocumentationPage.should_receive(:find).with(@doc_page.id.to_s)
    perform_action
  end

  it "should find the comment" do
    @doc_page.comments.should_receive(:find).with(@comment.id.to_s)
    perform_action
  end
  
  it_should_behave_like "deny access to area with 403 and user login"

  context "User is allowed to destroy comments" do
    before(:each) do
      controller.stub!(:can?).and_return(true)
    end

    it "should destroy the comment" do
      @comment.should_receive(:destroy)
      perform_action
    end

    it "should redirect to the comment's documentation page" do
      perform_action
      response.should redirect_to(documentation_page_url(@doc_page))
    end

    it "should inform the user of the successful deleteion" do
      perform_action
      flash[:notice].should contain("Comment deleted")
    end
  end
end