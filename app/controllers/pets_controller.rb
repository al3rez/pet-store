class PetsController < ApplicationController
  before_action :authenticate!, only: [:create]

  def index
    render json: Pet.includes(:user).all
  end

  def show
    render json: Pet.includes(:user).find(params[:id])
  end

  def create
    param! :name, String, required: true
    param! :pet_type, String, in: Pet.pet_types.keys, required: true

    pet = Pet.create!(
        user: current_user,
        name: params[:name],
        pet_type: params[:pet_type]
    )

    render json: pet, status: :created
  end
end
