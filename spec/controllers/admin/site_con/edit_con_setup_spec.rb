require 'spec_helper'

describe Admin::SiteConfigController, "Providing form to update site configuration" do
  before(:each) do
    SiteConfig.stub!(:find_or_create_default!).and_return(@config = mock_model(SiteConfig))
  end
  
  def perform_action
    get :edit
  end

  it_should_behave_like "deny access to area with 403 and user login"

  it "should check the user can edit the site config" do
    controller.should_receive(:can?).with(:update, @config)
    perform_action
  end

  context "User can edit the site config" do
    before(:each) do
      controller.stub!(:can?).and_return(true)
    end

    it "should find the correct site config" do
      SiteConfig.should_receive(:find_or_create_default!)
      perform_action
    end
  end
end
