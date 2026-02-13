class AddDetailToProduct < ActiveRecord::Migration[8.1]
  def change
    add_column :products, :description, :text
    add_column :products, :price, :decimal
  end
end
