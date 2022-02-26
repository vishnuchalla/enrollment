class GoodnessValidator < ActiveModel::Validator
    def validate(record)
        email_regx = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
        if !record.Email.match(email_regx)
            record.errors.add :base, "invalid email"
        end
    end


end

class Student < ApplicationRecord
    # has_many :courses
    validates :Name, :presence => true
    validates :Email, :presence => true
    validates :Password, :presence => true
    validates :date_of_birth, :presence => true
    validates :Phone_Number, :presence => true, length: {maximum:10}
    validates :Major, :presence => true
    validates_with GoodnessValidator

end
