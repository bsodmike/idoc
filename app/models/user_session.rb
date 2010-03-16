class UserSession < Authlogic::Session::Base

  def account_inactive?
    attempted_record && !attempted_record.active?
  end
end