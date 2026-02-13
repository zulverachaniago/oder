class AddSignatureToProduct < ActiveRecord::Migration[8.1]
  def change
    add_column :products, :signature, :boolean
  end
end
