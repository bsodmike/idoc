require 'rubygems'
require 'spork'

ENV["RAILS_ENV"] ||= 'test'
Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However, 
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
  require 'spec/autorun'
  require 'spec/rails'
  require 'webrat'
  require "email_spec"
  Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}
  require File.expand_path(File.join(File.dirname(__FILE__), 'shared_specs/shared_controller_spec'))
end

Spork.each_run do
  # This code will be run each time you run your specs.

end

Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  config.include Webrat::Matchers, :type => :views
  config.include EmailSpec::Matchers
  config.include EmailSpec::Helpers
  config.include CommentsControllerHelpers, :type => :controllers
  config.include CommentModelHelpers, :type => :models
  config.include DocumentationPagesControllerHelpers, :type => :controllers
  config.include DocumentationPageModelHelpers, :type => :models
end
