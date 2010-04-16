require 'spec_helper'

describe Admin::DocumentAuthorListController, "Update the document author list" do
  before(:each) do
    DocumentAuthorList.stub!(:update_list)
    @params = {}
  end

  def perform_action
    put :update, :document_author_list => @params
  end

  it_should_behave_like "deny access to area with 403 and user login"

  it "should check the user can update the list" do
    controller.should_receive(:can?).with(:update, DocumentAuthorList)
    perform_action
  end

  context "User can update list" do
    before(:each) do
      controller.stub!(:can?).and_return(true)
    end

    it "should update the document author list" do
      DocumentAuthorList.should_receive(:update_list).with(@params)
      perform_action
    end

    it "should redirect the user to the document author list" do
      perform_action
      response.should redirect_to(admin_document_author_list_url)
    end

    context "providing feedback" do
      it "should add 'Document author added' to the notice when a single document author is added" do
        @params = {:add_document_authors => [1]}
        perform_action
        flash[:notice].should contain("Document author added")
      end

      it "should add 'Document authors added' to the notice when several document authors are added" do
        @params = {:add_document_authors => [1, 2]}
        perform_action
        flash[:notice].should contain("Document authors added")
      end

      it "should add 'Document author removed' to the notice when a single document authors is removed" do
        @params = {:remove_document_authors => [1]}
        perform_action
        flash[:notice].should contain("Document author removed")
      end

      it "should add 'Document authors removed' to the notice when several document authors are removed" do
        @params = {:remove_document_authors => [1, 2]}
        perform_action
        flash[:notice].should contain("Document authors removed")
      end
    end
  end
end