require 'spec_helper'

describe Admin::SiteConfigController, "Displaying site configuration" do
  def perform_action
    get :show
  end

  it_should_behave_like "deny access to area with 403 and user login"

  it "should check the user can read the site config" do
    controller.should_receive(:can?).with(:read, @site_config)
    perform_action
  end
end