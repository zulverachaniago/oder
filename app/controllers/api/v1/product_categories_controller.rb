class Api::V1::ProductCategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_product_category, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @q = ProductCategory.ransack(params[:q])
    @product_categories = @q.result(distinct: true).order(created_at: :desc)
    render json: { result: "success", data: @product_categories }
  end

  def show
    render json: { result: "success", data: @product_category }
  end

  def create
    @product_category = ProductCategory.new(product_category_params)
    if @product_category.save
      render json: { result: "success", data: @product_category }
    else
      render json: { result: "error", errors: @product_category.errors.full_messages }
    end
  end

  def update
    if @product_category.update(product_category_params)
      render json: { result: "success", data: @product_category }
    else
      render json: { result: "error", errors: @product_category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @product_category.destroy
    render json: { result: "success", message: "Product category deleted" }
  end

  private
  def set_product_category
    @product_category = ProductCategory.friendly.find(params[:id])
  end

  def record_not_found
    render json: { result: "error", message: "Product category not found" }, status: :not_found
  end

  def product_category_params
    params.require(:product_category).permit(:name, :slug)
  end
end