require 'test_helper'

class PetsControllerTest < ActionDispatch::IntegrationTest
  test "all users can view pets without authentication" do
    get pets_url
    assert_response :ok
  end

  test "all users can view pet details without authentication" do
    pet_owner = User.create!(
        email: "test@example.com",
        password: "123456@",
        password_confirmation: "123456@",
        role: "pet_owner"
    )

    pet = Pet.create!(
        name: "foo",
        pet_type: "dog",
        user: @pet_owner
    )

    get url_for(pet)

    assert_equal "foo", json_response["name"]
    assert_response :ok
  end
end
