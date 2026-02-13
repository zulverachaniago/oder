class Api::V1::ProductTypesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_product_types, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @q = ProductType.ransack(params[:q])
    @product_types = @q.result(distinct: true).order(created_at: :desc)
    render json: { result: "success", data: @product_types }
  end

  def show
    render json: { result: "success", data:{
      id: @product_types.id,
      name: @product_types.name,
      slug: @product_types.slug,
      created_at: @product_types.created_at,
      updated_at: @product_types.updated_at,
      product_category_id: @product_types.product_category_id,
      product_category_name: @product_types.product_category.name,
    } }
  end

  def create
    @product_type = ProductType.new(product_types_params)
    if @product_type.save
      render json: { result: "success", data: @product_type }
    else
      render json: { result: "error", errors: @product_type.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @product_types.update(product_types_params)
      render json: { result: "success", data: @product_types }
    else
      render json: { result: "error", errors: @product_types.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @product_types.destroy
    render json: { result: "success", message: "Product type deleted" }
  end

  private
  def set_product_types
    @product_types = ProductType.friendly.find(params[:id])
  end

  def record_not_found
    render json: { result: "error", message: "Product type not found" }, status: :not_found
  end

  def product_types_params
    params.require(:product_type).permit(:name, :slug, :product_category_id)
  end
end