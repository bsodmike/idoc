require 'spec_helper'

describe DocumentationPagesController, "Documentation root handling" do
  def perform_action
    get :root
  end

  context "User is signed in and no pages exist" do
    before(:each) do
      DocumentationPage.stub!(:roots).and_return([])
      controller.stub!(:can?).and_return(true)
    end

    it "should confirm the user can create pages" do
      controller.should_receive(:can?).with(:create, DocumentationPage)
      perform_action
    end

    it "should render the new page form" do
      perform_action
      response.should render_template('documentation_pages/new')
    end
  end

  context "User is signed out and no pages exist" do
    before(:each) do
      DocumentationPage.stub!(:roots).and_return([])
      controller.stub!(:can?).and_return(false)
    end

    it "should confirm the user can't create pages" do
      controller.should_receive(:can?).with(:create, DocumentationPage)
      perform_action
    end

    it "should redirect the user to the logon page" do
      perform_action
      response.should redirect_to(new_user_session_url)
    end
  end

  context "documentation pages exist" do
    before(:each) do
      @doc_page = mock_model(DocumentationPage)
      DocumentationPage.stub!(:roots).and_return([@doc_page])
      controller.stub!(:can?).and_return(true)
    end

    it "should confirm the user can view the page" do
      controller.should_receive(:can?).with(:read, @doc_page)
      perform_action
    end

    it "should redirect the user to the single page" do
      perform_action
      response.should render_template('documentation_pages/show')
    end
  end
end