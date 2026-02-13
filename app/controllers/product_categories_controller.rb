class ProductCategoriesController < ApplicationController
  before_action :set_product_category, only: %i[ show edit update destroy ]
  before_action :add_product_categories_breadcrumb, only: %i[ show new edit ]

  # GET /product_categories or /product_categories.json
  def index
    add_breadcrumb "Product Categories"
    @q = ProductCategory.ransack(params[:q])
    @product_categories = @q.result(distinct: true).order(created_at: :desc)
    @total_categories = @product_categories.count
  end

  # GET /product_categories/1 or /product_categories/1.json
  def show
    add_breadcrumb @product_category.name
  end

  # GET /product_categories/new
  def new
    add_breadcrumb "New"
    @product_category = ProductCategory.new
  end

  # GET /product_categories/1/edit
  def edit
    add_breadcrumb @product_category.name, product_category_path(@product_category)
    add_breadcrumb "Edit"
  end

  # POST /product_categories or /product_categories.json
  def create
    @product_category = ProductCategory.new(product_category_params)

    respond_to do |format|
      if @product_category.save
        format.html { redirect_to @product_category, notice: "Product category was successfully created." }
        format.json { render :show, status: :created, location: @product_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_categories/1 or /product_categories/1.json
  def update
    respond_to do |format|
      if @product_category.update(product_category_params)
        format.html { redirect_to @product_category, notice: "Product category was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @product_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_categories/1 or /product_categories/1.json
  def destroy
    @product_category.destroy!

    respond_to do |format|
      format.html { redirect_to product_categories_path, notice: "Product category was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def add_product_categories_breadcrumb
    add_breadcrumb "Product Categories", product_categories_path
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_product_category
      @product_category = ProductCategory.friendly.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def product_category_params
      params.expect(product_category: [ :name, :slug ])
    end
end
