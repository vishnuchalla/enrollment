class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :Name
      t.string :Description
      t.string :Instructor_Name
      t.string :Weekday1
      t.string :Weekday2
      t.time :Start_Time
      t.time :End_Time
      t.string :Course_Code
      t.integer :Capacity
      t.integer :Waitlist_Capacity
      t.string :Room
      t.string :Status
      t.timestamps
    end
  end
end
