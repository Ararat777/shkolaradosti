class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.string :title
      t.string :path
      t.references :reportable,polymorphic: true,index: true
      t.timestamps
    end
  end
end
