class GoodnessValidator1 < ActiveModel::Validator
    def validate(record)
      days = ["MON","TUE","WED","THU","FRI"]
      t_format = /([01]\d|2[0-3]):([0-5]\d)/
      c_code_format = /([A-Z]{3}\d{3})/
      if !record.Start_Time.match(t_format)
        record.errors.add :base, "start time issue"
      end
      if !record.Course_Code.match(c_code_format)
        record.errors.add :base, "invaid course code format"
      end
      if record.Weekday1 == record.Weekday2
        record.errors.add :base, "Weekday 1 cannot be equal to Weekday 2"
      end
      record.errors.add :base, "Weekday 1 invalid" if !days.include?(record.Weekday1) 
      record.errors.add :base, "Weekday 2 invalid" if !days.include?(record.Weekday2) 

    end
  end


class Course < ApplicationRecord
    # belongs_to :instructor
    validates :Name, :presence => true
    validates :Weekday1, :presence => true
    # validates :Weekday2, :presence => true
    validates :Start_Time, :presence => true
    validates :End_Time, :presence => true
    validates :Description, :presence => true
    validates :Course_Code, :presence => true
    validates :Capacity, :presence => true
    validates :Room, :presence => true

    validates_with GoodnessValidator1



 
end
