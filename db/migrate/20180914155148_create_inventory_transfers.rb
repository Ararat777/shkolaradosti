class CreateInventoryTransfers < ActiveRecord::Migration[5.1]
  def change
    create_table :inventory_transfers do |t|
      t.integer :from_branch
      t.integer :to_branch
      t.string :inventory_category_title
      t.integer :size
      t.integer :status,default: 0
      t.text :comment
      t.timestamps
    end
  end
end
