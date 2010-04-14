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
      @ability.can?(:read, User).should be_false
    end

    it "should not be able to update a user" do
      @ability.can?(:update, User).should be_false
    end

    it "should not be able to destroy a user" do
      @ability.can?(:destroy, User).should be_false
    end
  end
end