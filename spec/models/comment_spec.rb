require 'spec_helper'

describe Comment do

  it "should not be valid if no comment body was provided" do
    comment = Comment.new
    comment.valid?.should be_false
  end
end
