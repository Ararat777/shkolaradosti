class CreateBranches < ActiveRecord::Migration[5.1]
  def change
    create_table :branches do |t|
      t.string :title
      t.string :adress
      t.text :comment
      t.timestamps
    end
  end
end
