require 'spec_helper'

describe Admin::SiteConfigController, "Displaying site configuration" do
  before(:each) do
    SiteConfig.stub!(:find_or_create_default!).and_return(@config = mock_model(SiteConfig))
  end
  def perform_action
    get :show
  end

  it_should_behave_like "deny access to area with 403 and user login"

  it "should check the user can read the site config" do
    controller.should_receive(:can?).with(:read, @config)
    perform_action
  end
end