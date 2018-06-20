require 'test_helper'

class PetsControllerTest < ActionDispatch::IntegrationTest
  test "users can view pets without authentication" do
    get pets_url
    assert_response :ok
  end
end
