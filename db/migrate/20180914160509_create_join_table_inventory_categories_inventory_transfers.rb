class CreateJoinTableInventoryCategoriesInventoryTransfers < ActiveRecord::Migration[5.1]
  def change
    create_table :inventory_categories_transfers,id: false do |t|
      t.belongs_to :inventory_category,index: true
      t.belongs_to :inventory_transfer,index: true
    end
  end
end
