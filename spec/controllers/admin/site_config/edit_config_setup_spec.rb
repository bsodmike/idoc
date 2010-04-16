require 'spec_helper'

describe Admin::SiteConfigController, "Providing form to update site configuration" do
  def perform_action
    get :edit
  end

  it_should_behave_like "deny access to area with 403 and user login"
end
