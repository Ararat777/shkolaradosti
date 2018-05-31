class CreateParents < ActiveRecord::Migration[5.1]
  def change
    create_table :parents do |t|
      t.string :father_name
      t.string :father_phone
      t.string :father_additional_phone
      t.string :father_adress
      t.string :father_work_adress
      t.date :father_birthdate
      t.string :father_email
      
      t.string :mother_name
      t.string :mother_phone
      t.string :mother_additional_phone
      t.string :mother_adress
      t.string :mother_work_adress
      t.date :mother_birthdate
      t.string :mother_email
      t.timestamps
    end
  end
end
