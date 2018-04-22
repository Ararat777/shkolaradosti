class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.string :title
      t.decimal :price
      t.belongs_to :branch,index: true
      t.timestamps
    end
  end
end
