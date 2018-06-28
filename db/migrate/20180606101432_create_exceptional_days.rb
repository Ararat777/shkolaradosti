class CreateExceptionalDays < ActiveRecord::Migration[5.1]
  def change
    create_table :exceptional_days do |t|
      t.string :title
      t.date :day
      t.boolean :is_holiday
      t.belongs_to :month,index: true
      t.timestamps
    end
  end
end
