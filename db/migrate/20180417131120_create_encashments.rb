class CreateEncashments < ActiveRecord::Migration[5.1]
  def change
    create_table :encashments do |t|
      t.decimal :amount
      t.text :comment
      t.belongs_to :cash_box
      t.timestamps
    end
  end
end
