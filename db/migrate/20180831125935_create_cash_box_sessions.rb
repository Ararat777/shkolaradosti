class CreateCashBoxSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :cash_box_sessions do |t|
      t.datetime :closed_at
      t.belongs_to :cash_box,index: true
      t.timestamps
    end
  end
end
