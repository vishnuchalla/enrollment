class CourseValidator<ActiveModel::Validator
  def validate(record)
    days = ["MON", "TUE", "WED", "THU", "FRI"]
    status = ["OPEN", "CLOSED", "WAITLIST"]
    c_code_format = /([A-Z]{3}\d{3})/
    email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    record.errors.add :base, "Start Time should be less than End Time" if (record.Start_Time.utc.strftime("%H%M%S%N") > record.End_Time.utc.strftime("%H%M%S%N"))
    record.errors.add :base, "invalid course code format" unless record.Course_Code.match(c_code_format)
    record.errors.add :base, "invalid Instructor email format" unless record.instructoremail.match(email_regex)
    record.errors.add :base, "Weekday1 cannot be equal to Weekday2" if record.Weekday1 == record.Weekday2
    record.errors.add :base, "Weekday1 invalid" unless days.include?(record.Weekday1)
    record.errors.add :base, "Room should be a non-empty string" if record.Room.nil? || record.Room.empty?
    record.errors.add :base, "Course capacity must be a positive number" if (not record.Capacity >= 0)
    record.errors.add :base, "Waitlist capacity must be a positive number" if (not record.Waitlist_Capacity.nil? and not record.Waitlist_Capacity >= 0)
  end
end

class Course < ApplicationRecord
  has_many :enrolls , dependent: :destroy
  has_many :waitlists, dependent: :destroy
  #belongs_to:instructor
  validates :Name, :presence => true
  validates :Weekday1, :presence=>true
  validates :Start_Time, :presence=>true
  validates :End_Time, :presence=>true
  validates :Description, :presence=>true
  validates :Course_Code, :presence=>true, :uniqueness=>true
  validates :Capacity, :presence=>true
  validates :Room, :presence=>true
  validates :Instructor_Name, :presence=>true
  validates :instructoremail, :presence=>true
  validates_with CourseValidator
end