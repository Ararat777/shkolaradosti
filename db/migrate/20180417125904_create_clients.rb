class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :age
      t.text :allergy
      t.text :comment
      t.belongs_to :branch,index: true
      t.belongs_to :discount,index: true
      t.belongs_to :parent,index: true
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
