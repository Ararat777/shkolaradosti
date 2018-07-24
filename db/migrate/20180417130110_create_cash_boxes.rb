class CreateCashBoxes < ActiveRecord::Migration[5.1]
  def change
    create_table :cash_boxes do |t|
      t.decimal :cash,default: 0
      t.belongs_to :branch,index: true
      t.timestamps
    end
  end
end
