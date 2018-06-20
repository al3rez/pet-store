class CategoriesController < ApplicationController
  before_action :authenticate!, only: %i[create update delete]
  before_action -> { authorize!(%i[pet_owner manager]) }, only: %i[create update destroy]

  def index
    render json: Category.includes(:user).all
  end

  def show
    render json: Category.includes(:user).find(params[:id])
  end

  def create
    param! :name, String, required: true

    category = Category.create!(
        user: current_user,
        name: params[:name],
    )

    render json: category, status: :created
  end
end
