class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :Name
      t.date :date_of_birth
      t.integer :Phone_Number
      t.string :Major
      t.string :Student_ID
      t.string :email
      t.string :password_digest

      t.timestamps
    end
    add_index :students, :email, unique: true
  end
end
