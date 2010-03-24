require 'spec_helper'

describe DocumentationPagesController, "editing an existing page (performing the update)" do
  before(:each) do
    setup_update_page
  end
  def perform_action
    post :update, :id => @doc_page.id, :documentation_page => {}
  end
  it_should_behave_like "finding menu items"
  it_should_behave_like "requires user logon"

  it "should find the documentation page" do
    perform_action
    assigns[:documentation_page].should == @doc_page
  end

  it "should update the documentation page's attributes and then save" do
    @doc_page.should_receive(:update_attributes).once.ordered.with({})
    @doc_page.should_receive(:save).once.ordered
    perform_action
  end

  context "successful update" do
    it "should inform the user of the successful update" do
      perform_action
      flash[:notice].should contain("Page successfully updated")
    end

    it "should return the user to the documentation page" do
      perform_action
      response.should redirect_to(documentation_page_url(@doc_page))
    end
  end

  context "unsuccessful update" do
    before(:each) do
      @doc_page.stub!(:save).and_return(false)
      create_all_pages_array(@doc_page)
    end
    it "should inform the user of an error occuring" do
      perform_action
      flash[:error].should contain("Errors occured during page update")
    end

    it "should find all the documentation pages" do
      DocumentationPage.should_receive(:find).with(:all).and_return(@all_pages)
      perform_action
    end

    it "should remove the current page from it's all_documents output" do
      perform_action
      assigns[:all_documents].should == (@all_pages - [@doc_page])
    end

    it "should provide the user with the update form again" do
      perform_action
      response.should render_template("documentation_pages/edit")
    end
  end
end
