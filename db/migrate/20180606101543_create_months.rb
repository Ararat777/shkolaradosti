class CreateMonths < ActiveRecord::Migration[5.1]
  def change
    create_table :months do |t|
      t.string :title
      t.integer :number
      t.integer :year
      t.integer :work_days_size
      t.timestamps
    end
  end
end
