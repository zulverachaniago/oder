class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).order(created_at: :desc)
    render json: { result: "success", data: {
      products: @products.map do |product|
        {
          id: product.id,
          name: product.name,
          image: product.image.attached? ? image_url_for(product.image) : nil,
          slug: product.slug,
          description: product.description,
          product_category_id: product.product_category_id,
          product_category_name: product.product_category.name,
          product_type_id: product.product_type_id,
          product_type_name: product.product_type.name,
          price: product.price,
          created_at: product.created_at,
          updated_at: product.updated_at,
        }
      end
    } }
  end

  # GET /products/1 or /products/1.json
  def show
    render json: { result: "success", data:{
      id: @product.id,
      name: @product.name,
      image: @product.image.attached? ? image_url_for(@product.image) : nil,
      slug: @product.slug,
      description: @product.description,
      product_category_id: @product.product_category_id,
      product_category_name: @product.product_category.name,
      product_type_id: @product.product_type_id,
      product_type_name: @product.product_type.name,
      price: @product.price,
      created_at: @product.created_at,
    } }
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_path, notice: "Product was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def image_url_for(attachment)
      "#{request.scheme}://#{request.host_with_port}#{rails_blob_path(attachment.blob)}"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.friendly.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.expect(product: [ :name, :product_category_id, :product_type_id, :slug, :description, :price, :image ])
    end
end
