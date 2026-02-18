class AddLevelToProduct < ActiveRecord::Migration[8.1]
  def change
    add_column :products, :level, :boolean
  end
end
