require 'spec_helper'

describe Ability, "User session abilities" do
  context "User is not logged in" do
    before(:each) do
      @ability = Ability.new(nil)
    end

    it "should be able to create a session" do
      @ability.can?(:create, UserSession).should be_true
    end

    it "should not be able to update a session" do
      @ability.can?(:update, UserSession).should be_false
    end

    it "should not be able to read a session" do
      @ability.can?(:read, UserSession).should be_false
    end

    it "should not be able to destroy a session" do
      @ability.can?(:destroy, UserSession).should be_false
    end
  end

  context "User is logged in" do
    before(:each) do
      @user = mock_model(User, :admin => false, :moderator => false)
      @session = mock_model(UserSession, :record => @user)
      @other_session = mock_model(UserSession, :record => @other_user)
      @ability = Ability.new(@user)
    end

    it "should not be able to create a session" do
      @ability.can?(:create, UserSession).should be_false
    end

    it "should be able to read their own session" do
      @ability.can?(:read, @session).should be_true
    end

    it "should be able to update their own session" do
      @ability.can?(:update, @session).should be_true
    end

    it "should be able to destroy their own session" do
      @ability.can?(:destroy, @session).should be_true
    end

    it "should not be able to read, update or destroy another's session" do
      @ability.can?(:read, @other_session).should be_false
      @ability.can?(:update, @other_session).should be_false
      @ability.can?(:destroy, @other_session).should be_false
    end
  end

  context "User is a moderator in" do
    before(:each) do
      @user = mock_model(User, :admin => false, :moderator => true)
      @session = mock_model(UserSession, :record => @user)
      @other_session = mock_model(UserSession, :record => @other_user)
      @ability = Ability.new(@user)
    end

    it "should not be able to create a session" do
      @ability.can?(:create, UserSession).should be_false
    end

    it "should be able to read their own session" do
      @ability.can?(:read, @session).should be_true
    end

    it "should be able to update their own session" do
      @ability.can?(:update, @session).should be_true
    end

    it "should be able to destroy their own session" do
      @ability.can?(:destroy, @session).should be_true
    end

    it "should not be able to read, update or destroy another's session" do
      @ability.can?(:read, @other_session).should be_false
      @ability.can?(:update, @other_session).should be_false
      @ability.can?(:destroy, @other_session).should be_false
    end
  end

  context "User is an administrator in" do
    before(:each) do
      @user = mock_model(User, :admin => true, :moderator => false)
      @session = mock_model(UserSession, :record => @user)
      @other_session = mock_model(UserSession, :record => @other_user)
      @ability = Ability.new(@user)
    end

    it "should not be able to create a session" do
      @ability.can?(:create, UserSession).should be_false
    end

    it "should be able to read a session" do
      @ability.can?(:read, @session).should be_true
      @ability.can?(:read, @other_session).should be_true
    end

    it "should be able to update a session" do
      @ability.can?(:update, @session).should be_true
      @ability.can?(:update, @other_session).should be_true
    end

    it "should be able to destroy a session" do
      @ability.can?(:destroy, @session).should be_true
      @ability.can?(:destroy, @other_session).should be_true
    end
  end
end