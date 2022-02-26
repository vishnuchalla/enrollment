json.extract! instructor, :id, :Name, :Department, :email, :created_at, :updated_at
json.url instructor_url(instructor, format: :json)
