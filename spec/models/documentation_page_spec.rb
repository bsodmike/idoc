require 'spec_helper'

describe DocumentationPage do

  it "should not be valid without a title" do
    page = DocumentationPage.new(:content => "Some test content")
    page.valid?.should be_false
  end

  it "should not be valid without content" do
    page = DocumentationPage.new(:title => "Testing title")
    page.valid?.should be_false
  end

  it "should set the position to the lowest value if no position is provided" do
    DocumentationPage.create(:title => "Test title", :content => "Some content", :position => 1)
    page = DocumentationPage.new(:title => "Testing title", :content => "Some test content")
    page.save
    page.position.should == DocumentationPage.maximum(:position)
  end
end
