class MypagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  def home
    @product_categories = ProductCategory.all
    @signature_product = Product.find_by(signature: true)
  end

  def contact
    @product_categories = ProductCategory.all
  end

  def about_us
  end

  def product
  end
end
