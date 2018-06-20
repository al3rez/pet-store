require 'test_helper'

class PetsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @password = "1234567@"
    @customer = User.create!(
        role: :customer,
        email: "test+1@gmail.com",
        password: @password,
        password_confirmation: @password
    )
    @pet_owner = User.create!(
        role: :pet_owner,
        email: "test+2@gmail.com",
        password: @password,
        password_confirmation: @password
    )
    @manager = User.create!(
        role: :manager,
        email: "test+3@gmail.com",
        password: @password,
        password_confirmation: @password
    )
  end

  test "all users can view pets without authentication" do
    get pets_url
    assert_response :ok
  end

  test "all users can view pet details without authentication" do
    pet = Pet.create!(
        name: "foo",
        pet_type: "dog",
        user: @pet_owner
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
    post pets_url, params: { pet_type: "dog" }, headers: login_basic(@pet_owner.email, @password)
    assert_response :bad_request
  end

  test "users cannot create pets with duplicate in their own scope name" do
    post pets_url, params: { name: "foo", pet_type: "dog" }, headers: login_basic(@pet_owner.email, @password)
    assert_response :created

    post pets_url, params: { name: "foo", pet_type: "dog" }, headers: login_basic(@manager.email, @password)
    assert_response :created

    post pets_url, params: { name: "foo", pet_type: "dog" }, headers: login_basic(@pet_owner.email, @password)
    assert_response :bad_request
  end

  test "users cannot create pets without pet_type" do
    post pets_url, params: { name: "foo" }, headers: login_basic(@pet_owner.email, @password)
    assert_response :bad_request
  end

  test "users cannot create pets with invalid pet_type" do
    post pets_url, params: { name: "foo", pet_type: "invalid" }, headers: login_basic(@pet_owner.email, @password)
    assert_response :bad_request
  end

  test "customers cannot create pets" do
    post pets_url, params: { name: "bar", pet_type: "dog"}, headers: login_basic(@customer.email, @password)
    assert_response :forbidden
  end

  test "users can only update their own pets" do
    pet1 = Pet.create!(name: "foo", pet_type: "cat", user: @pet_owner)
    pet2 = Pet.create!(name: "foo", pet_type: "cat", user: @manager)

    put url_for(pet1), params: { name: "bar", pet_type: "dog"}, headers: login_basic(@pet_owner.email, @password)
    assert_response :no_content

    put url_for(pet2), params: { name: "bar", pet_type: "dog"}, headers: login_basic(@pet_owner.email, @password)
    assert_response :not_found
  end

end
