# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_iDoc_session',
  :secret      => '5000b32acd1ec95ce9444c26355020d5e0538c207f93e7f785723f08a527dce63f1454051516f96eea66ce98eb10c1c0645c7a8acbc7739bd000e24a77055521'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
