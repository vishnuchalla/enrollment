class AddInstructoremailToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :instructoremail, :string
  end
end
