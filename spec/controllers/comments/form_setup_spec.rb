require 'spec_helper'

describe CommentsController, "Creating a new comment (form setup)" do
  before(:each) do
    setup_new_comment
  end
  def perform_action
    get :new, :documentation_page_id => @doc_page.id
  end
  it_should_behave_like "finding menu items"
  it_should_behave_like "requires user logon"

  it "should find the documentation page parent" do
    perform_action
    assigns[:documentation_page].should == @doc_page
  end

  it "should set up the data for the form" do
    perform_action
    assigns[:comment].should == @comment
  end
end