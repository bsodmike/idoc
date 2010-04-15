require 'spec_helper'

describe ModeratorList do

  before(:each) do
    @moderators = [mock_model(User, :is_moderator? => true), mock_model(User, :is_moderator? => true)]
    @users = [mock_model(User, :is_moderator? => false)]
    User.stub!(:find).and_return(@moderators + @users)
  end

  it "should find moderator users" do
    ModeratorList.moderators.should == @moderators
  end

  it "should find normal users" do
    ModeratorList.users.should == @users
  end

  context "Updating moderator list" do
    before(:each) do
      User.stub!(:find).and_return(@users)
      @users.each{|u|u.stub(:moderator=); u.stub!(:save!)}
    end
    it "should find the specified users" do
      User.should_receive(:find).with(@users)
      ModeratorList.update_list(:add_moderators => @users)
    end

    it "should set the moderator status of found users to true" do
      @users.each {|u| u.should_receive(:moderator=).with(true)}
      ModeratorList.update_list(:add_moderators => @users)
    end

    it "should save each user with the new state" do
      @users.each {|u| u.should_receive(:save!)}
      ModeratorList.update_list(:add_moderators => @users)
    end

    it "should not try to find users if passed an empty array for add_moderators" do
      User.should_not_receive(:find)
      ModeratorList.update_list(:add_moderators => [])
    end

    it "should not try to find users if passed an empty array for remove_moderators" do
      User.should_not_receive(:find)
      ModeratorList.update_list(:remove_moderators => [])
    end

    it "should find the specified moderators" do
      User.should_receive(:find).with(@users)
      ModeratorList.update_list(:remove_moderators => @users)
    end

    it "should set the moderator status of found moderators to false" do
      @users.each {|u| u.should_receive(:moderator=).with(false)}
      ModeratorList.update_list(:remove_moderators => @users)
    end

    it "should save the demoted moderators" do
      @users.each {|u| u.should_receive(:save!)}
      ModeratorList.update_list(:remove_moderators => @users)
    end
  end
end
