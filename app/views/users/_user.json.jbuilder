json.extract! user, :id, :name, :date_of_birth, :phone_number, :major, :department, :user_type, :email, :created_at, :updated_at
json.url user_url(user, format: :json)
