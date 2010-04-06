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
end
