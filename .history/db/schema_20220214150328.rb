# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 2022_02_14_190509) do
=======
ActiveRecord::Schema.define(version: 2022_02_14_190113) do
>>>>>>> origin/Student

  create_table "courses", force: :cascade do |t|
    t.string "Name"
    t.string "Description"
    t.string "Instructor_Name"
    t.string "Weekday1"
    t.string "Weekday2"
    t.time "Start_Time"
    t.time "End_Time"
    t.string "Course_Code"
    t.integer "Capacity"
    t.integer "Waitlist_Capacity"
    t.string "Room"
    t.string "Status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
<<<<<<< HEAD
    t.string "instructoremail"
=======
  end

  create_table "enrolls", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "student_id", null: false
    t.integer "course_id", null: false
    t.index ["course_id"], name: "index_enrolls_on_course_id"
    t.index ["student_id"], name: "index_enrolls_on_student_id"
>>>>>>> origin/Student
  end

  create_table "instructors", force: :cascade do |t|
    t.string "Name"
    t.string "Department"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_instructors_on_email", unique: true
  end

  create_table "students", force: :cascade do |t|
    t.string "Name"
    t.date "date_of_birth"
    t.integer "Phone_Number"
    t.string "Major"
    t.string "Student_ID"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_students_on_email", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.date "date_of_birth"
    t.string "phone_number"
    t.string "major"
    t.string "department"
    t.string "user_type"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "enrolls", "courses"
  add_foreign_key "enrolls", "students"
end
