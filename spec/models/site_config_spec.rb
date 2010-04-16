require 'spec_helper'

describe SiteConfig do
  it "should create a default configuration if there is no config already" do
    SiteConfig.destroy_all
    @site_config = SiteConfig.find_or_create_default!
    @site_config.site_title.should == 'iDoc'
  end

  it "should return the existing configuration if present" do
    SiteConfig.destroy_all
    @existing_config = SiteConfig.create!(:site_title => "Testing")
    @site_config = SiteConfig.find_or_create_default!
    @site_config.site_title.should == @existing_config.site_title
  end

  it "should create a new configuration if there is no config already" do
    SiteConfig.destroy_all
    @site_config = SiteConfig.update_or_create!(:site_title => "Testing site")
    @site_config.site_title.should == "Testing site"
  end

  it "should update the existing record if it already exists" do
    SiteConfig.destroy_all
    @existing_config = SiteConfig.create!(:site_title => "Test")
    SiteConfig.update_or_create!(:site_title => "Testing site")
    @existing_config.reload
    @existing_config.site_title.should == "Testing site"
  end
end
