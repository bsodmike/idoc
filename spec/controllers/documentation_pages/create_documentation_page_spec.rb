require 'spec_helper'

describe DocumentationPagesController, "creating a new page" do
  before(:each) do
    @failed_logon_error_message = "You must be logged on to add documentation"
    @doc_page = mock_model(DocumentationPage)
    @doc_page.stub!(:save!)
    DocumentationPage.stub!(:new).and_return(@doc_page)
    controller.stub(:can?).and_return(true)
  end
  def perform_action
    post :create, :documentation_page => {}
  end
  it_should_behave_like "finding menu items"

  it "should check the user can create pages" do
    controller.should_receive(:can?).with(:create, DocumentationPage)
    perform_action
  end

  context "User can create pages" do
    it "should create the page" do
      DocumentationPage.should_receive(:new).with({})
      perform_action
    end

    it "should attempt to save the page" do
      @doc_page.should_receive(:save!)
      perform_action
    end

    context "with valid data" do

      it "should redirect to the new documentation page" do
        perform_action
        response.should redirect_to(documentation_page_url(@doc_page))
      end

      it "should inform the user of the successful creation" do
        perform_action
        flash[:notice].should contain("Page added")
      end
    end

    context "with invalid data" do
      before(:each) do
        @doc_page.stub!(:save!).and_raise(ActiveRecord::RecordNotSaved)
        create_all_pages_array(@doc_page)
      end

      it "should inform the user of the problem" do
        perform_action
        flash[:error].should contain("Errors existed in the documentation page")
      end

      it "should provide the user with the form to correct the mistake" do
        perform_action
        response.should render_template('documentation_pages/new')
      end

      it "should find all the documentation pages" do
        perform_action
        assigns[:all_documents].should == @all_pages - [@doc_pages]
      end
    end
  end

  context "User isn't allowed to create pages" do
    context "User isn't logged in" do
      before(:each) do
        controller.stub(:can?).and_return(false)
      end

      it "should redirect the user to the login page" do
        perform_action
        response.should redirect_to(new_user_session_url)
      end

      it "should inform the user of the problem" do
        perform_action
        flash[:error].should contain("You must be logged on to add documentation")
      end
    end
  end
end