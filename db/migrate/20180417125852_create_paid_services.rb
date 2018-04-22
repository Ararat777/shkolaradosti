class CreatePaidServices < ActiveRecord::Migration[5.1]
  def change
    create_table :paid_services do |t|
      t.date :start_date
      t.date :end_date
      t.belongs_to :service,index: true
      t.belongs_to :client,index:true
      t.text :comment
      t.boolean :status,default: true
      t.float :amount,default: 0
      t.float :required_amount
      t.timestamps
    end
  end
end
