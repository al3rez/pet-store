# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'user cannot sign up without email' do
    post sign_up_url, params: {}
    assert_response :bad_request
  end

  test 'user cannot sign up without password' do
    post sign_up_url, params: { email: 'test@example.com' }
    assert_response :bad_request
  end

  test "user cannot sign up when password doesn't match" do
    post sign_up_url, params: { email: 'test@example.com', password: '123456', password_confirmation: 'nomatch' }
    assert_response :bad_request
  end

  test 'user cannot sign up without as' do
    post sign_up_url,params: { email: 'test@example.com', password: '1245678@', password_confirmation: '1245678@' }
    assert_response :bad_request
  end

  test 'user cannot sign up with invalid role' do
    post sign_up_url, params: { as: 'badrole', email: 'test@example.com', password: '1245678@', password_confirmation: '1245678@' }
    assert_response :bad_request
  end

  test 'user sign up properly' do
    post sign_up_url, params: { as: 'pet_owner', email: 'test@example.com', password: '1245678@', password_confirmation: '1245678@' }
    user = JSON.parse(@response.body)
    assert_equal 'test@example.com', user['email']
    assert_response :created
  end
end
