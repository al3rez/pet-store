class PetsController < ApplicationController
  def index
    render json: Pet.includes(:user).all
  end

  def show
    render json: Pet.includes(:user).find(params[:id])
  end
end
