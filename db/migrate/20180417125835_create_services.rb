class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.string :title
      t.float :price
      t.boolean :countable,default: false
      t.boolean :active, default: true
      t.belongs_to :branch,index: true
      t.text :comment
      t.timestamps
    end
  end
end
