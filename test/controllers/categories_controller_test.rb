require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "all users can view categories without authentication" do
    get categories_url
    assert_response :ok
  end
end
