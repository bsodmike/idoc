require 'spec_helper'

describe "the menu navigation" do
  
  before(:each) do
    assigns[:menu_items] = [mock_model(DocumentationPage, :title => "testing")]
    render :partial => 'shared/menu'
  end
  
  it "should have a menu list" do
    response.should have_selector("ul.menu")
  end
  
  it "should have a menu item" do
    response.should have_selector("ul") do |list|
      list.should have_selector("li") do |item|
        item.should contain "testing"
      end
    end
  end
  
end