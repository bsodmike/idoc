require 'spec_helper'

describe DocumentationPagesController, "editing an existing page (providing the form)" do
  before(:each) do
    setup_edit_form
    controller.stub!(:can?).and_return(true)
  end
  def perform_action
    get :edit, :id => @doc_page.id
  end
  it_should_behave_like "finding menu items"

  it "should check the user has update permission for the page" do
    controller.should_receive(:can?).with(:update, @doc_page)
    perform_action
  end

  it "should find the documentation page" do
    perform_action
    assigns[:documentation_page].should == @doc_page
  end

  context "User can update the page" do

    it "should find all the documentation pages" do
      DocumentationPage.should_receive(:find).with(:all).and_return(@all_pages)
      perform_action
    end

    it "should remove the current page from it's all_documents output" do
      perform_action
      assigns[:all_documents].should == (@all_pages - [@doc_page])
    end
  end

  context "User cannot update the page" do
    before(:each) do
      controller.stub!(:can?).and_return(false)
    end
    context "User is not logged in" do

      it "should redirect the user to the logon page" do
        perform_action
        response.should redirect_to(new_user_session_url)
      end

      it "should inform the user of the problem" do
        perform_action
        flash[:error].should contain("You must be logged on to edit documentation")
      end
    end
  end
end