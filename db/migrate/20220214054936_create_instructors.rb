class CreateInstructors < ActiveRecord::Migration[7.0]
  def change
    create_table :instructors do |t|
      t.string :Name
      t.string :Department
      t.string :email
      t.string :password_digest

      t.timestamps
    end
    add_index :instructors, :email, unique: true
  end
end
