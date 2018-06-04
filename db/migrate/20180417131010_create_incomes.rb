class CreateIncomes < ActiveRecord::Migration[5.1]
  def change
    create_table :incomes do |t|
      t.string :acceptor
      t.string :title
      t.integer :service
      t.float :amount
      t.integer :client
      t.text :comment
      t.belongs_to :cash_box,index: true
      t.timestamps
    end
  end
end
