module CommentsControllerHelpers
  def setup_new_comment
    setup_shared_comment
  end

  def setup_create_comment
    setup_shared_comment
    @comment.stub!(:save).and_return(true)
  end

  private

  def setup_shared_comment
    @failed_logon_error_message = "You must be logged on to add a comment"
    @doc_page = mock_model(DocumentationPage, :comments => (@comments =  mock("comment_list")))
    @comments.stub!(:build).and_return(@comment = mock_model(Comment))
    @comment.stub!(:user=)
    DocumentationPage.stub!(:find).and_return(@doc_page)
  end
end

module CommentModelHelpers

end