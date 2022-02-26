class AddKeysToEnrolls < ActiveRecord::Migration[7.0]
  def change
    add_reference :enrolls, :student, null: false, foreign_key: true
    add_reference :enrolls, :course, null: false, foreign_key: true
  end
end
