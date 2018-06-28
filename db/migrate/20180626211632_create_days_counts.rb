class CreateDaysCounts < ActiveRecord::Migration[5.1]
  def change
    create_table :days_counts do |t|
      t.integer :count_days
      t.integer :current_count_days
      t.belongs_to :paid_service,index: true
      t.timestamps
    end
  end
end
