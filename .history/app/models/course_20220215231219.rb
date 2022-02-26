class CourseValidator<ActiveModel::Validator
  def validate(record)
    days = ["MON", "TUE", "WED", "THU", "FRI"]
    status = ["OPEN", "CLOSED", "WAITLIST"]
    c_code_format = /([A-Z]{3}\d{3})/
    record.errors.add :base, "Start Time should be less than End Time" if (record.Start_Time > record.End_Time)
    record.errors.add :base, "invalid course code format" unless record.Course_Code.match(c_code_format)
    record.errors.add :base, "Weekday1 cannot be equal to Weekday2" if record.Weekday1==record.Weekday2
    record.errors.add :base, "Weekday1 invalid" unless days.include?(record.Weekday1)
    record.errors.add :base, "Weekday2 invalid" if !record.Weekday2.nil? and !days.include?(record.Weekday2)
    record.errors.add :base, "Status Invalid" unless status.include?(record.Status)
    record.errors.add :base, "Room should be a non-empty string" if record.Room.nil? || record.Room.empty?
    puts record.Capacity
    puts record.Waitlist_Capacity
    record.errors.add :base, "Course capacity must be greater than 0" if (not record.Capacity > 0)
    record.errors.add :base, "Waitlist capacity must be greater than 0" if (not record.Waitlist_Capacity.nil? and not record.Waitlist_Capacity > 0)
  end
end

class Course < ApplicationRecord
  has_many :enrolls, dependent: :destroy
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
  validates :Status, :presence => true
  validates_with CourseValidator
end