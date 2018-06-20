class CategoriesController < ApplicationController
  def index
    render json: Category.includes(:user).all
  end

  def show
    render json: Category.includes(:user).find(params[:id])
  end

end
