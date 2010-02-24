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
end
