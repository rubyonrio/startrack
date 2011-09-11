require 'simplecov'
SimpleCov.start 'rails'

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require "capybara/rails"
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all
  include Capybara::DSL
end

class ActionController::TestCase
  include Devise::TestHelpers
end