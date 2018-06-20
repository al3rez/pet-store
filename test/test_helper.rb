ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def json_response
    JSON.parse(@response.body)
  end

  def login_basic(email, password)
    {
        HTTP_AUTHORIZATION: ActionController::HttpAuthentication::Basic.encode_credentials(email, password)
    }
  end
end