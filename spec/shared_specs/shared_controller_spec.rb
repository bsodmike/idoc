require 'spec_helper'
if !@included then
  shared_examples_for "finding menu items" do
    before(:each) do
      @find_method = controller.method(:find_menu_items)
      controller.stub!(:find_menu_items).and_return(true)
    end
    it "should attempt to find items for the menu" do
      controller.should_receive(:find_menu_items)
      perform_action
    end

    it "should find all the root documents" do
      DocumentationPage.should_receive(:roots)
      @find_method.call
    end
  end

  shared_examples_for "requires user logon" do
    before(:each) do
      UserSession.stub(:find).and_return(@user_session = mock_model(UserSession))
    end

    context "with an identified user" do
      before(:each) do
        @doc_page = mock_model(DocumentationPage, :save => true)
        DocumentationPage.stub!(:new).and_return(@doc_page)
        UserSession.stub(:find).and_return(@user_session = mock_model(UserSession))
      end

      it "should check for a logged in user" do
        UserSession.should_receive(:find)
        perform_action
      end
    end

    context "without an identified user" do
      before(:each) do
        UserSession.stub!(:find).and_return(nil)
      end

      it "should check for a logged in user" do
        UserSession.should_receive(:find)
        perform_action
      end

      it "should inform the user of the problem" do
        perform_action
        flash[:error].should contain(@failed_logon_error_message)
      end

      it "should put the user on the account logon page" do
        perform_action
        response.should redirect_to(new_user_session_url)
      end
    end
  end
  @included = true
end