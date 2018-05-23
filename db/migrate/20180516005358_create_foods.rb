class CreateFoods < ActiveRecord::Migration[5.1]
  def change
    create_table :foods do |t|
      t.float :price
      t.float :amount, default: 0
      t.integer :count_days, default: 0
      t.string :paid_days, default: "0"
      t.belongs_to :client
      t.text :comment
      t.timestamps
    end
  end
end
