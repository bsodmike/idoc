require 'spec_helper'

describe DocumentAuthorList do

  before(:each) do
    @authors = [mock_model(User, :is_author? => true), mock_model(User, :is_author? => true)]
    @users = [mock_model(User, :is_author? => false)]
    User.stub!(:find).and_return(@authors + @users)
  end

  it "should find document authors" do
    DocumentAuthorList.authors.should == @authors
  end

  it "should find normal users" do
    DocumentAuthorList.users.should == @users
  end

  context "Updating document author list" do
    before(:each) do
      User.stub!(:find).and_return(@users)
      @users.each{|u|u.stub(:document_author=); u.stub!(:save!)}
    end
    it "should find the specified users" do
      User.should_receive(:find).with(@users)
      DocumentAuthorList.update_list(:add_document_authors => @users)
    end

    it "should set the document author status of found users to true" do
      @users.each {|u| u.should_receive(:document_author=).with(true)}
      DocumentAuthorList.update_list(:add_document_authors => @users)
    end

    it "should save each user with the new state" do
      @users.each {|u| u.should_receive(:save!)}
      DocumentAuthorList.update_list(:add_document_authors => @users)
    end

    it "should not try to find users if passed an empty array for add_document_authors" do
      User.should_not_receive(:find)
      DocumentAuthorList.update_list(:add_document_authors => [])
    end

    it "should not try to find users if passed an empty array for remove_document_authors" do
      User.should_not_receive(:find)
      DocumentAuthorList.update_list(:remove_document_authors => [])
    end

    it "should find the specified document authors" do
      User.should_receive(:find).with(@users)
      DocumentAuthorList.update_list(:remove_document_authors => @users)
    end

    it "should set the moderator status of found moderators to false" do
      @users.each {|u| u.should_receive(:document_author=).with(false)}
      DocumentAuthorList.update_list(:remove_document_authors => @users)
    end

    it "should save the demoted moderators" do
      @users.each {|u| u.should_receive(:save!)}
      DocumentAuthorList.update_list(:remove_document_authors => @users)
    end
  end
end