json.extract! student, :id, :Name, :date_of_birth, :Phone_Number, :Major, :Student_ID, :email, :created_at, :updated_at
json.url student_url(student, format: :json)
