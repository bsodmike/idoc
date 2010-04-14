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

  shared_examples_for "deny access to area with 403 and user login" do
    before(:each) do
      controller.stub!(:can?).and_return(false)
    end

    context "User is logged in but not allowed to view" do
      before(:each) do
        controller.stub!(:current_user).and_return(mock_model(User))
      end

      it "should provide the user a 403 Forbidden error" do
        perform_action
        response.status.should contain("403")
      end

      it "should render nothing" do
        perform_action
        response.should render_template('shared/403')
      end
    end

    context "User is not logged in" do
      before(:each) do
        controller.stub!(:current_user).and_return(nil)
      end

      it "should redirect the user to the login page" do
        perform_action
        response.should redirect_to(new_user_session_url)
      end

      it "should inform the user they must be logged in" do
        perform_action
        flash[:error].should contain("You must be logged in to access this area")
      end
    end
  end
  @included = true
end