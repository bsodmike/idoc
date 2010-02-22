class User < ActiveRecord::Base
  acts_as_authentic

  after_create :send_signup_confirmation!

  def send_signup_confirmation!
    UserSignup.deliver_confirmation_email(self)
  end
end
