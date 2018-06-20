class PetsController < ApplicationController
  before_action :authenticate!, only: %i[create update delete]
  before_action -> { authorize!(%i[pet_owner manager]) }, only: %i[create update destroy]


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
