class GoodnessValidator < ActiveModel::Validator
    def validate(record) 
        if !record.Email.match(VALID_EMAIL_REGEX)
            record.errors.add :base, "invalid email"
        end
    end


end

class Instructor < ApplicationRecord
    has_many :courses
    validates :Name, :presence => true
    validates :Email, :presence => true
    validates :Password, :presence => true
    validates :Department, :presence => true
    validates_with GoodnessValidator

end
