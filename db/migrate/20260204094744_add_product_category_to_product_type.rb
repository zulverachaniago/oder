class AddProductCategoryToProductType < ActiveRecord::Migration[8.1]
  def change
    add_reference :product_types, :product_category, null: false, foreign_key: true
  end
end
