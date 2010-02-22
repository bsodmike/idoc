class UserSignup < ActionMailer::Base

  def confirmation_email(user)
    recipients user.email
    body :perishable_token => user.perishable_token
  end
end
