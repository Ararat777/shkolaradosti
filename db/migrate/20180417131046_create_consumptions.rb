class CreateConsumptions < ActiveRecord::Migration[5.1]
  def change
    create_table :consumptions do |t|
      t.string :consumption_title
      t.float :amount
      t.text :comment
      t.belongs_to :cash_box,index: true
      t.timestamps
    end
  end
end
