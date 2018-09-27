class CreatePaidPeriods < ActiveRecord::Migration[5.1]
  def change
    create_table :paid_periods do |t|
      t.string :title
      t.date :start_date
      t.date :end_date
      t.float :required_amount
      t.float :paid_amount
      t.float :lack,default: 0
      t.float :countable_balance
      t.boolean :active
      t.integer :total_paid_days_size
      t.integer :rest_paid_days_size
      t.belongs_to :paid_service,index: true
      t.timestamps
    end
  end
end
