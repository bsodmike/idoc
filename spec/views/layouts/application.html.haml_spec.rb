require 'spec_helper'

describe "the application main layout" do

  before(:each) do
    assigns[:menu_items] = @menu_items = mock("menu_items")
    template.stub!(:render).with(:partial => 'shared/menu', :object => @menu_items)
  end
  
  def do_render
    render :text => "Test render", :layout => 'application'
  end
  
  it "should contain the template text" do
    do_render
    response.should contain "Test render"
  end
  
  it "should render the _menu partial" do
    template.should_receive(:render).with(:partial => 'shared/menu', :object => @menu_items)
    do_render
  end
  
end