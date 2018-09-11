class CreateInventoryCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :inventory_categories do |t|
      t.string :title
      t.integer :size
      t.belongs_to :branch
      t.timestamps
    end
  end
end
