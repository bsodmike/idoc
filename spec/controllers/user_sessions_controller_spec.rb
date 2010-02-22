require 'spec_helper'

describe UserSessionsController do
  context "Logging out (destroying the session)" do
    context "when the user is logged in" do
      before(:each) do
        UserSession.stub!(:find).and_return(@user_session = mock_model(UserSession, :destroy => true))
      end
      it "should find the session" do
        UserSession.should_receive(:find)
        delete :destroy
      end

      it "should destroy the session" do
        @user_session.should_receive(:destroy)
        delete :destroy        
      end

      it "should redirect to the home page" do
        delete :destroy
        response.should redirect_to(root_url)
      end
    end
    context "when the user is logged out" do

      before(:each) do
        UserSession.stub!(:find).and_return(nil)
      end
      it "should find the session" do
        UserSession.should_receive(:find)
        delete :destroy
      end

      it "should redirect to the home page" do
        delete :destroy
        response.should redirect_to(root_url)
      end
    end
  end

end
