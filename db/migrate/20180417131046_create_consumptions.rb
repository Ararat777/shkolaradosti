class CreateConsumptions < ActiveRecord::Migration[5.1]
  def change
    create_table :consumptions do |t|
      t.string :title
      t.float :amount
      t.text :comment
      t.belongs_to :cash_box_session,index: true
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
