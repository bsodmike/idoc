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

  context "A flash[:notice] message is present" do
    it "should render a box for the flash message" do
      flash[:notice] = "Test message"
      do_render
      response.should have_selector("div.notice") do |d|
        d.should contain "Test message"
      end
    end
  end

  context "A flash[:notice message is not present" do
    it "should not render a box for the flash message" do
      do_render
      response.should_not have_selector("div.notice")
    end
  end


end