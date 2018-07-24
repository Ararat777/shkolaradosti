class CreateTransfers < ActiveRecord::Migration[5.1]
  def change
    create_table :transfers do |t|
      t.integer :from_cashbox
      t.integer :to_cashbox
      t.float :amount
      t.integer :status,default: 0
      t.integer :kind,default: 0
      t.text :comment
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
