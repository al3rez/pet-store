require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
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
    @pet_owner2 = User.create!(
        role: :pet_owner,
        email: "test+22@gmail.com",
        password: @password,
        password_confirmation: @password
    )
    @manager = User.create!(
        role: :manager,
        email: "test+3@gmail.com",
        password: @password,
        password_confirmation: @password
    )
    @pet = Pet.create!(name: "foo", pet_type: "cat", user: @pet_owner)
    @pet2 = Pet.create!(name: "foo", pet_type: "cat", user: @pet_owner2)
    @category = Category.create!(name: "foo", user: @pet_owner)
    @category2 = Category.create!(name: "foo", user: @pet_owner2)
  end

  test "all users can view categories without authentication" do
    get categories_url
    assert_response :ok
  end

  test "all users can view pet details without authentication" do
    get url_for(@category)

    assert_equal @category.name, json_response["name"]
    assert_response :ok
  end

  test "users cannot create categories without authentication" do
    post categories_url, params: { name: "foo" }
    assert_response :unauthorized
  end

  test "users cannot create pets without name" do
    post categories_url, params: { }, headers: login_basic(@pet_owner.email, @password)
    assert_response :bad_request
  end

  test "users cannot create categories with duplicate name in their own scope" do
    post categories_url, params: { name: "bar" }, headers: login_basic(@pet_owner.email, @password)
    assert_response :created

    post categories_url, params: { name: "foo" }, headers: login_basic(@manager.email, @password)
    assert_response :created

    post categories_url, params: { name: "foo" }, headers: login_basic(@pet_owner.email, @password)
    assert_response :bad_request
  end

  test "customers cannot create categories" do
    post categories_url, params: { name: "bar" }, headers: login_basic(@customer.email, @password)
    assert_response :forbidden
  end

  test "users can only update their own categories" do
    put url_for(@category), params: { pet_ids: [@pet.id] }, headers: login_basic(@pet_owner.email, @password)
    assert_response :no_content

    put url_for(@category2), params: { pet_ids: [@pet2.id] }, headers: login_basic(@pet_owner.email, @password)
    assert_response :not_found
  end

  test "customers cannot update categories" do
    put url_for(@category), params: { pet_ids: [@pet.id] }, headers: login_basic(@customer.email, @password)
    assert_response :forbidden
  end

  test "managers can update others categories" do
    put url_for(@category), params: { pet_ids: [@pet.id] }, headers: login_basic(@manager.email, @password)
    assert_response :no_content
  end
end
