class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name
      t.references :product_category, null: false, foreign_key: true
      t.references :product_type, null: false, foreign_key: true
      t.string :slug

      t.timestamps
    end
    add_index :products, :slug, unique: true
  end
end
