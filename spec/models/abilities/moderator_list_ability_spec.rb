require 'spec_helper'

describe Ability, "Moderator list abilities" do
  context "User not logged in" do
    before(:each) do
      @ability = Ability.new(nil)
    end

    it "should not be able to read the moderator list" do
      @ability.can?(:read, ModeratorList).should be_false
    end

    it "should not be able to update the moderator list" do
      @ability.can?(:update, ModeratorList).should be_false
    end

    it "should not be able to create a moderator list" do
      @ability.can?(:create, ModeratorList).should be_false
    end

    it "should not be able to destroy the moderator list" do
      @ability.can?(:destroy, ModeratorList).should be_false
    end
  end

  context "User is logged in" do
    before(:each) do
      @user = mock_model(User, :moderator => false, :admin => false)
      @ability = Ability.new(@user)
    end
    
    it "should not be able to read the moderator list" do
      @ability.can?(:read, ModeratorList).should be_false
    end

    it "should not be able to update the moderator list" do
      @ability.can?(:update, ModeratorList).should be_false
    end

    it "should not be able to create a moderator list" do
      @ability.can?(:create, ModeratorList).should be_false
    end

    it "should not be able to destroy the moderator list" do
      @ability.can?(:destroy, ModeratorList).should be_false
    end
  end

  context "User is a moderator" do
    before(:each) do
      @user = mock_model(User, :moderator => true, :admin => false)
      @ability = Ability.new(@user)
    end

    it "should not be able to read the moderator list" do
      @ability.can?(:read, ModeratorList).should be_false
    end

    it "should not be able to update the moderator list" do
      @ability.can?(:update, ModeratorList).should be_false
    end

    it "should not be able to create a moderator list" do
      @ability.can?(:create, ModeratorList).should be_false
    end

    it "should not be able to destroy the moderator list" do
      @ability.can?(:destroy, ModeratorList).should be_false
    end
  end

  context "User is an administrator" do
    before(:each) do
      @user = mock_model(User, :moderator => false, :admin => true)
      @ability = Ability.new(@user)
    end

    it "should be able to read the moderator list" do
      @ability.can?(:read, ModeratorList).should be_true
    end

    it "should be able to update the moderator list" do
      @ability.can?(:update, ModeratorList).should be_true
    end

    it "should not be able to create the moderator list" do
      @ability.can?(:create, ModeratorList).should be_false
    end

    it "should not be able to destroy the moderator list" do
      @ability.can?(:destroy, ModeratorList).should be_false
    end
  end
end