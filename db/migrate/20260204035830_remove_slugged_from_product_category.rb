class RemoveSluggedFromProductCategory < ActiveRecord::Migration[8.1]
  def change
    remove_column :product_categories, :slugged, :string
  end
end
