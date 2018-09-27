class CreateIncomes < ActiveRecord::Migration[5.1]
  def change
    create_table :incomes do |t|
      t.string :acceptor
      t.string :title
      t.float :amount
      t.text :comment
      t.integer :client_id
      t.integer :service_id
      t.belongs_to :cash_box_session,index: true
      t.belongs_to :paid_period,index: true
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
