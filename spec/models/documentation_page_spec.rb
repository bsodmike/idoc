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
    page.position.should == DocumentationPage.maximum(:position, :conditions => "parent_id IS NULL")
  end

  it "should have an 'up' page when it has a parent" do
    page = DocumentationPage.create(:title => "Test title", :content => "Some content", :position => 1)
    subpage = DocumentationPage.new(:title => "Testing title", :content => "Some test content", :parent_id => page.id)
    subpage.has_up?.should be_true
  end

  it "should alter the position of later pages if a collision occurs" do
    page = DocumentationPage.create(:title => "Test title", :content => "Some content", :position => 1)
    page2 = DocumentationPage.create(:title => "Test title 2", :content => "Some content", :position => 1)
    DocumentationPage.find(page.id).position.should == 2
  end

  it "should return the parent page when the 'up' page is requested" do
    page = DocumentationPage.create(:title => "Test title", :content => "Some content", :position => 1)
    subpage = DocumentationPage.new(:title => "Testing title", :content => "Some test content", :parent_id => page.id)

    subpage.up.should == page
  end
  
  context "Single layer of documentation"  do
    it "should give a positive result with has_next? when there is a documentation page at the same level with a greater position" do
      page = DocumentationPage.create(:title => "Test", :content => "Some content")
      DocumentationPage.create(:title => "Another test", :content => "more content")
      page.has_next?.should be_true
    end

    it "should give a positive result with has_previous? when there is a documentation page at the same level with a lower position" do
      DocumentationPage.create(:title => "Test", :content => "Some content")
      page = DocumentationPage.create(:title => "Another test", :content => "more content")
      page.has_previous?.should be_true
    end

    it "should provide the next page when requested" do
      page1 = DocumentationPage.create(:title => "Test", :content => "Some content")
      page2 = DocumentationPage.create(:title => "Another test", :content => "more content")
      page1.next.should == page2
    end

    it "should provide the previous page when requested" do
      page1 = DocumentationPage.create(:title => "Test", :content => "Some content")
      page2 = DocumentationPage.create(:title => "Another test", :content => "more content")
      page2.previous.should == page1

    end
  end

  context "Multiple layers of documentation" do
    context "finding the next item of an item with children" do
      it "should have a next item when a page has children" do
        page1 = DocumentationPage.create(:title => "Test", :content => "Some content")
        page2 = DocumentationPage.create(:title => "Another test", :content => "more content", :parent_id => page1.id)
        page1.has_next?.should be_true
      end

      it "should return the first of it's children when requested" do

        page1 = DocumentationPage.create(:title => "Test", :content => "Some content")
        page2 = DocumentationPage.create(:title => "Another test", :content => "more content")

        subpage1 = DocumentationPage.create(:title => "Test 2", :content => "Some content", :parent_id => page1.id)
        page1.next.should == subpage1
      end
    end

    context "finding the next item of the last of an items children" do
      it "should have a next item when the parent has a next item" do
        page1 = DocumentationPage.create(:title => "Test", :content => "Some content")
        page2 = DocumentationPage.create(:title => "Another test", :content => "more content")

        subpage1 = DocumentationPage.create(:title => "Test 2", :content => "Some content", :parent_id => page1.id)
        subpage1.has_next?.should be_true
      end

      it "should have a next item corresponding to the next item of the parent" do
        page1 = DocumentationPage.create(:title => "Test", :content => "Some content")
        page2 = DocumentationPage.create(:title => "Another test", :content => "more content")

        subpage1 = DocumentationPage.create(:title => "Test 2", :content => "Some content", :parent_id => page1.id)
        subpage1.next.should == page2
      end
    end

    context "finding the previous item of an item before another item with children" do
      it "should have a previous item corresponding to the last child of the previous item" do
        page1 = DocumentationPage.create(:title => "Test", :content => "Some content")
        page2 = DocumentationPage.create(:title => "Another test", :content => "more content")

        subpage1 = DocumentationPage.create(:title => "Test 2", :content => "Some content", :parent_id => page1.id)
        page2.previous.should == subpage1
      end
    end
  end

end
