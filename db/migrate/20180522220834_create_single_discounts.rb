class CreateSingleDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :single_discounts do |t|
      t.string :title
      t.integer :percent
      t.integer :count
      t.boolean :active
      t.text :comment

      t.timestamps
    end
  end
end
