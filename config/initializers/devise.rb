# Use this hook to configure devise mailer, warden hooks and so forth. The first
# four configuration values can also be set straight in your models.
Devise.setup do |config|
  config.mailer_sender = "please-change-me@config-initializers-devise.com"

  config.pepper = "3aece9a5f48926ab3d1cf3bad0f34456848bbbba88fb032e51ac2776341e4c8a18efabc826165cdb4efd1e0534555f746c78163da384bd8013233da77d424c40"

  # (then you should set stretches to 10, and copy REST_AUTH_SITE_KEY to pepper)
  config.encryptor = :sha512

  config.authentication_keys = [ :email ]


  # ==> Configuration for :rememberable
  # The time the user will be remembered without asking for credentials again.
  config.remember_for = 2.weeks

  # ==> Configuration for :timeoutable
  # The time you want to timeout the user session without activity. After this
  # time the user will be asked for credentials again.
  config.timeout_in = 20.minutes

  # ==> Configuration for :lockable
  # Number of authentication tries before locking an account.
  config.maximum_attempts = 20

  # Defines which strategy will be used to unlock an account.
  # :email = Sends an unlock link to the user email
  # :time  = Reanables login after a certain ammount of time (see :unlock_in below)
  # :both  = enables both strategies
  config.unlock_strategy = :both

  # Time interval to unlock the account if :time is enabled as unlock_strategy.
  config.unlock_in = 1.hour
end
