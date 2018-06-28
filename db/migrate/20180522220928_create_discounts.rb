class CreateDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :discounts do |t|
      t.string :title
      t.integer :discount_size
      t.boolean :active,default: true
      t.text :comment

      t.timestamps
    end
  end
end
