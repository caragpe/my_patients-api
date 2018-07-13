# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  minimum_coverage '90'
end
require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'
require 'mocha/minitest'
require 'minitest/mock'
# require 'support/factory_bot'
require 'webmock/minitest'

class ActiveSupport::TestCase
  include ActiveJob::TestHelper
  include FactoryBot::Syntax::Methods
  # Setup fixtures in test/fixtures/*.yml for all tests (alphabetical order)
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def parsed_response
    JSON.parse(response.body)
  end
end
