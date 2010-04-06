# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem 'haml'
  config.gem 'compass'
  config.gem 'authlogic'
  config.gem 'friendly_id'
  config.gem 'sanitize'
  config.gem 'cancan'
  config.time_zone = 'UTC'
end