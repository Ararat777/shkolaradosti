class CreateEncashments < ActiveRecord::Migration[5.1]
  def change
    create_table :encashments do |t|
      t.float :amount
      t.text :comment
      t.belongs_to :cash_box,index: true
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
