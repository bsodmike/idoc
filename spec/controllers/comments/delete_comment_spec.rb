require 'spec_helper'

describe CommentsController, "Deleting a comment" do
  before(:each) do
    @comment = mock_model(Comment)
    @doc_page = mock_model(DocumentationPage, :comments => [@comment])
    DocumentationPage.stub!(:find).and_return(@doc_page)
  end

  def perform_action
    delete :destroy, :documentation_page_id => @doc_page.id, :id => @comment.id
  end
  
  it_should_behave_like "deny access to area with 403 and user login"
end