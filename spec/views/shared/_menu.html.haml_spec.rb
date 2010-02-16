require 'spec_helper'

describe "the menu navigation" do
  
  before(:each) do
    assigns[:menu_items] = [mock_model(DocumentationPage, :title => "testing")]
    render :partial => 'shared/menu'
  end
  
  def have_menu_item(text) 
    response.should have_selector("ul") do |list|
      list.should have_selector("li") do |list_item|
        list_item.should have_selector("a") do |link|
          link.should contain(text)
        end
      end
    end
  end
  
  it "should have a menu list" do
    response.should have_selector("ul.menu")
  end
  
  it "should have a menu item" do
    have_menu_item("testing")
  end
  
end