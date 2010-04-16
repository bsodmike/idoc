require 'spec_helper'

describe Admin::SiteConfigController, "Updating site configuration" do
  before(:each) do
    SiteConfig.stub!(:find_or_create_default!).and_return(@config = mock_model(SiteConfig))
    SiteConfig.stub!(:update_or_create!)
  end
  def perform_action
    put :update, :site_config => {}
  end

  it_should_behave_like "deny access to area with 403 and user login"

  it "should check the user can update the site configuration" do
    controller.should_receive(:can?).with(:update, @config)
    perform_action
  end
  
  context "User can update the site configuration" do
    before(:each) do
      controller.stub!(:can?).and_return(true)
    end

    it "should update the site config" do
      SiteConfig.should_receive(:update_or_create!).with({})
      perform_action
    end

    it "should inform the user of the successful change" do
      perform_action
      flash[:notice].should contain("Configuration saved")
    end

    it "should redirect the user to the site configuration display" do
      perform_action
      response.should redirect_to(admin_site_config_path)
    end
  end
  
end