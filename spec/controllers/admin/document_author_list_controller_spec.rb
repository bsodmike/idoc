require 'spec_helper'

describe Admin::DocumentAuthorListController do

  #Delete these examples and add some real ones
  it "should use Admin::DocumentAuthorListController" do
    controller.should be_an_instance_of(Admin::DocumentAuthorListController)
  end


  describe "GET 'edit'" do
    it "should be successful" do
      get 'edit'
      response.should be_success
    end
  end

  describe "GET 'update'" do
    it "should be successful" do
      get 'update'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      get 'show'
      response.should be_success
    end
  end
end
