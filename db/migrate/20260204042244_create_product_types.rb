class CreateProductTypes < ActiveRecord::Migration[8.1]
  def change
    create_table :product_types do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :product_types, :slug, unique: true
  end
end
