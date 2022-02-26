class RemoveColumnNameFromTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :date_of_birth
    remove_column :users, :phone_number
    remove_column :users, :major
    remove_column :users, :department
  end
end
