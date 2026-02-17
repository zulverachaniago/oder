class MypagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @product_categories = ProductCategory.all
    @signature_product = Product.find_by(signature: true, active: true)
  end

  def contact
    add_breadcrumb "Contact"
    @product_categories = ProductCategory.all
  end

  def about_us
    add_breadcrumb "About Us"
  end

  def product
    add_breadcrumb "Product"
  end

  def jde
    add_breadcrumb "JDE"
  end
end
