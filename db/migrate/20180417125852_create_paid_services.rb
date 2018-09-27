class CreatePaidServices < ActiveRecord::Migration[5.1]
  def change
    create_table :paid_services do |t|
      t.belongs_to :service,index: true
      t.belongs_to :client,index:true
      t.belongs_to :single_discount,index: true
      t.text :comment
      t.float :total_required_amount
      t.float :total_lack
      t.float :total_paid_amount
      t.datetime :canceled_at
      t.timestamps
    end
  end
end
