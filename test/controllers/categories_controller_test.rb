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
end
