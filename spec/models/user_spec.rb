require "spec_helper"

describe User do

  context "with valid attributes" do
    before(:each) do
      UserSignup.stub!(:deliver_confirmation_email)
      @valid_attributes = {:email => "test@test.com", :password => "password", :password_confirmation => "password", :displayname => "Tester"}
    end

    it "should send a confirmation email after being created" do
      @user = User.new(@valid_attributes)
      UserSignup.should_receive(:deliver_confirmation_email).with(@user)
      @user.save
    end

    it "should generate a new perishable token when created" do
      @user = User.new(@valid_attributes)
      @user.should_receive(:reset_perishable_token!)
      @user.save
    end

    it "should not set activated to true when provided with an activated parameter" do
      @valid_attributes[:active] = true
      @user = User.new(@valid_attributes)
      @user.active.should be_false
    end

    it "should be activated after calling activate!" do
      @user = User.new(@valid_attributes)
      @user.activate!
      @user.active.should be_true
    end

    it "should be saved after being activated" do
      @user = User.new(@valid_attributes)
      @user.activate!
      @user.changed?.should == false
    end

    it "should require a displayname of at least 3 characters" do
      @valid_attributes[:displayname] = "a"
      @user = User.new(@valid_attributes)
      @user.valid?.should be_false
      @user.displayname = "aaa"
      @user.valid?.should be_true
    end

    it "should not be a moderator initially" do
      @user = User.new(@valid_attributes)
      @user.is_moderator?.should be_false
    end

    it "should not be a document author initially" do
      @user = User.new(@valid_attributes)
      @user.is_author?.should be_false
    end
  end
end