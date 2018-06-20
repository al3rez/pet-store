require 'test_helper'

class PetsControllerTest < ActionDispatch::IntegrationTest
  test "all users can view pets without authentication" do
    get pets_url
    assert_response :ok
  end
end
