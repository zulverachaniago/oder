class ProductTypesController < ApplicationController
  before_action :set_product_type, only: %i[ show edit update destroy ]
  before_action :add_product_types_breadcrumb, only: %i[ show new edit ]

  # GET /product_types or /product_types.json
  def index
    add_breadcrumb "Product Types"
    @product_types = ProductType.all
  end

  # GET /product_types/1 or /product_types/1.json
  def show
    add_breadcrumb @product_type.name
  end

  # GET /product_types/new
  def new
    add_breadcrumb "New"
    @product_type = ProductType.new
  end

  # GET /product_types/1/edit
  def edit
    add_breadcrumb @product_type.name, product_type_path(@product_type)
    add_breadcrumb "Edit"
  end

  # POST /product_types or /product_types.json
  def create
    @product_type = ProductType.new(product_type_params)

    respond_to do |format|
      if @product_type.save
        format.html { redirect_to @product_type, notice: "Product type was successfully created." }
        format.json { render :show, status: :created, location: @product_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_types/1 or /product_types/1.json
  def update
    respond_to do |format|
      if @product_type.update(product_type_params)
        format.html { redirect_to @product_type, notice: "Product type was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @product_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_types/1 or /product_types/1.json
  def destroy
    @product_type.destroy!

    respond_to do |format|
      format.html { redirect_to product_types_path, notice: "Product type was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def add_product_types_breadcrumb
    add_breadcrumb "Product Types", product_types_path
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_product_type
      @product_type = ProductType.friendly.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def product_type_params
      params.expect(product_type: [ :name, :slug, :product_category_id ])
    end
end
