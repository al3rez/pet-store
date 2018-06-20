# frozen_string_literal: true

class UsersController < ApplicationController
  def sign_up
    param! :email, String, required: true
    param! :password, String, required: true
    param! :password_confirmation, String, required: true
    param! :as, String, in: User.roles.keys, required: true

    user = User.create!(
      role: params[:as],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )

    render json: user, status: :created
  end
end
