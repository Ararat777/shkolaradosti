class CreateSingleDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :single_discounts do |t|
      t.string :title
      t.integer :discount_size
      t.integer :count
      t.boolean :fixed
      t.boolean :active,default: true
      t.belongs_to :branch,index: true
      t.text :comment

      t.timestamps
    end
  end
end
