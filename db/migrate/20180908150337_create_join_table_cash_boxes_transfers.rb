class CreateJoinTableCashBoxesTransfers < ActiveRecord::Migration[5.1]
  def change
    create_table :cash_box_sessions_transfers,id: false do |t|
      t.belongs_to :cash_box_session,index: true
      t.belongs_to :transfer,index: true
    end
  end
end
