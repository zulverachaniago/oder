class AddActiveToProduct < ActiveRecord::Migration[8.1]
  def change
    add_column :products, :active, :boolean
    add_column :products, :sold_out, :boolean
  end
end
