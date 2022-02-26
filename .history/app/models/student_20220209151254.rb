class GoodnessValidator < ActiveModel::Validator
    def validate(record)
        #email_regx = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
        if !record.Email.match(VALID_EMAIL_REGEX)
            record.errors.add :base, "invalid email"
        end
    end


end

class Student < ApplicationRecord
    validates :Name, :presence => true
    validates :Email, :presence => true
    validates :Password, :presence => true
    validates :date_of_birth, :presence => true
    validates :Phone_Number, :presence => true
    validates :Major, :presence => true
    validates_with GoodnessValidator

end
