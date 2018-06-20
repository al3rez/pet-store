class CategoriesController < ApplicationController
  def index
    render json: Category.includes(:user).all
  end
end
