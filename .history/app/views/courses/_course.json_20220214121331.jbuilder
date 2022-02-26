json.extract! course, :id, :Name, :Description, :Instructor_Name, :Weekday1, :Weekday2, :Start_Time, :End_Time, :Course_Code, :Capacity, :Waitlist_Capacity, :Room, :Status, :created_at, :updated_at
json.url course_url(course, format: :json)
