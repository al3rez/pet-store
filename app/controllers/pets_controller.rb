class PetsController < ApplicationController
  def index
    render json: Pet.includes(:user).all
  end
end
