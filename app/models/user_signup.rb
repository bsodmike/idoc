class UserSignup < ActionMailer::Base

  def confirmation_email(user)
    recipients user.email
  end
end
