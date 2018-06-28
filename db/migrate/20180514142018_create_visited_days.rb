class CreateVisitedDays < ActiveRecord::Migration[5.1]
  def change
    create_table :visited_days do |t|
      t.date :day
      t.belongs_to :client,index: true
      t.timestamps
    end
  end
end
