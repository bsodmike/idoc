require 'spec_helper'

describe DocumentationPagesController, "Documentation root handling" do
  def perform_action
    get :index
  end

  context "No pages exist" do
    before(:each) do
      DocumentationPage.stub!(:roots).and_return([])
    end

    it_should_behave_like "deny access to area with 403 and user login"

    context "User can create pages" do
      before(:each) do
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
  end

  context "documentation pages exist" do
    before(:each) do
      @doc_page = mock_model(DocumentationPage)
      DocumentationPage.stub!(:roots).and_return([@doc_page])
    end

    it_should_behave_like "deny access to area with 403 and user login"

    context "User can read pages" do
      before(:each) do
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
end