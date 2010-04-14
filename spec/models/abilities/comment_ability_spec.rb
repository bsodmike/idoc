require 'spec_helper'

describe Ability, "Comment abilities" do
  context "No user logged in" do
    before(:each) do
      @ability = Ability.new(nil)
    end

    it "should be able to read comments" do
      @ability.can?(:read, Comment.new).should be_true
    end

    it "should not be able to create comments" do
      @ability.can?(:create, Comment).should be_false
    end

    it "should not be able to update comments" do
      @ability.can?(:update, Comment.new).should be_false
    end

    it "should not be able to destroy comments" do
      @ability.can?(:destroy, Comment.new).should be_false
    end
  end

  context "Normal user is logged in" do
    before(:each) do
      @user = mock_model(User, :admin => false, :moderator => false)
      @ability = Ability.new(@user)
    end

    it "should be able to read comments" do
      @ability.can?(:read, Comment.new).should be_true
    end

    it "should be able to create comments" do
      @ability.can?(:create, Comment).should be_true
    end

    it "should be not be able to update comments" do
      @ability.can?(:update, Comment.new).should be_false
    end

    it "should not be able to destroy comments" do
      @ability.can?(:destroy, Comment.new).should be_false
    end
  end

  context "Moderator is logged in" do
    before(:each) do
      @user = mock_model(User, :admin => false, :moderator => true)
      @ability = Ability.new(@user)
    end

    it "should be able to read comments" do
      @ability.can?(:read, Comment.new).should be_true
    end

    it "should be able to create comments" do
      @ability.can?(:create, Comment).should be_true
    end

    it "should be able to destroy comments" do
      @ability.can?(:destroy, Comment.new).should be_true
    end

    it "should be able to update comments" do
      @ability.can?(:update, Comment.new).should be_true
    end
  end

  context "Administrator is logged in" do
    before(:each) do
      @user = mock_model(User, :admin => true, :moderator => false)
      @ability = Ability.new(@user)
    end

    it "should be able to read comments" do
      @ability.can?(:read, Comment.new).should be_true
    end

    it "should be able to create comments" do
      @ability.can?(:create, Comment).should be_true
    end

    it "should be able to destroy comments" do
      @ability.can?(:destroy, Comment.new).should be_true
    end

    it "should be able to update comments" do
      @ability.can?(:update, Comment.new).should be_true
    end    
  end
end