require 'test_helper'

class PetsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @password = "1234567@"
    @user1 = User.create!(email: "test+1@gmail.com", password: @password, password_confirmation: @password)
    @user2 = User.create!(email: "test+2@gmail.com", password: @password, password_confirmation: @password)
  end

  test "all users can view pets without authentication" do
    get pets_url
    assert_response :ok
  end

  test "all users can view pet details without authentication" do
    pet = Pet.create!(
        name: "foo",
        pet_type: "dog",
        user: @user1
    )

    get url_for(pet)

    assert_equal "foo", json_response["name"]
    assert_response :ok
  end

  test "users cannot create pets without authentication" do
    post pets_url, params: { name: "foo", pet_type: "dog" }
    assert_response :unauthorized
  end

  test "users cannot create pets without name" do
    post pets_url, params: { pet_type: "dog" }, headers: login_basic(@user1.email, @password)
    assert_response :bad_request
  end

  test "users cannot create pets with duplicate in their own scope name" do
    post pets_url, params: { name: "foo", pet_type: "dog" }, headers: login_basic(@user1.email, @password)
    assert_response :created

    post pets_url, params: { name: "foo", pet_type: "dog" }, headers: login_basic(@user2.email, @password)
    assert_response :created

    post pets_url, params: { name: "foo", pet_type: "dog" }, headers: login_basic(@user1.email, @password)
    assert_response :bad_request
  end

  test "users cannot create pets without pet_type" do
    post pets_url, params: { name: "foo" }, headers: login_basic(@user1.email, @password)
    assert_response :bad_request
  end

  test "users cannot create pets with invalid pet_type" do
    post pets_url, params: { name: "foo", pet_type: "invalid" }, headers: login_basic(@user1.email, @password)
    assert_response :bad_request
  end
end
