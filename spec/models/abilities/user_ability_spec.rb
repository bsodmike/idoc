require 'spec_helper'

describe Ability, "User abilites" do
  context "User is not logged in" do
    before(:each) do
      @ability = Ability.new(nil)
    end

    it "should be able to create a user" do
      @ability.can?(:create, User).should be_true
    end

    it "should not be able to read a user" do
      @ability.can?(:read, User.new).should be_false
    end

    it "should not be able to update a user" do
      @ability.can?(:update, User.new).should be_false
    end

    it "should not be able to destroy a user" do
      @ability.can?(:destroy, User.new).should be_false
    end
  end

  context "User is logged in" do
    before(:each) do
      @user = mock_model(User, :admin => false, :moderator => false)
      @ability = Ability.new(@user)
    end

    it "should not be able to create a user" do
      @ability.can?(:create, User).should be_false
    end

    it "should be able to read their own user" do
      @ability.can?(:read, @user).should be_true
    end

    it "should be able to update their own user" do
      @ability.can?(:update, @user).should be_true
    end

    it "should be able to destroy their own user" do
      @ability.can?(:destroy, @user).should be_true
    end

    it "should not be able to read, update or destroy another user" do
      @other_user = mock_model(User)
      @ability.can?(:read, @other_user).should be_false
      @ability.can?(:update, @other_user).should be_false
      @ability.can?(:destroy, @other_user).should be_false
    end
  end

  context "User is a moderator" do
    before(:each) do
      @user = mock_model(User, :moderator => true, :admin => false)
      @ability = Ability.new(@user)
    end

    it "should not be able to create a user" do
      @ability.can?(:create, User).should be_false
    end

    it "should be able to read their own user" do
      @ability.can?(:read, @user).should be_true
    end

    it "should be able to update their own user" do
      @ability.can?(:update, @user).should be_true
    end

    it "should be able to destroy their own user" do
      @ability.can?(:destroy, @user).should be_true
    end

    it "should not be able to read, update or destroy another user" do
      @other_user = mock_model(User)
      @ability.can?(:read, @other_user).should be_false
      @ability.can?(:update, @other_user).should be_false
      @ability.can?(:destroy, @other_user).should be_false
    end
  end

  context "User in an administrator" do
    before(:each) do
      @user = mock_model(User, :admin => true, :moderator => false)
      @other_user = mock_model(User)
      @ability = Ability.new(@user)
    end

    it "should be able to create users" do
      @ability.can?(:create, User).should be_true
    end

    it "should be able to read users" do
      @ability.can?(:read, @user).should be_true
      @ability.can?(:read, @other_user).should be_true
    end

    it "should be able to updated users" do
      @ability.can?(:update, @user).should be_true
      @ability.can?(:update, @other_user).should be_true
    end

    it "should be able to destroy users" do
      @ability.can?(:destroy, @user).should be_true
      @ability.can?(:destroy, @other_user).should be_true
    end
  end
end