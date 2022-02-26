class GoodnessValidator < ActiveModel::Validator
    def validate(record) 
        email_regx = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
        if !record.Email.match(email_regx)
            record.errors.add :base, "invalid email"
        end
    end


end

class Instructor < ApplicationRecord
    # has_many :courses
    validates :Name, :presence => true
    validates :Email, :presence => true
    validates :Password, :presence => true
    validates :Department, :presence => true
    validates_with GoodnessValidator

end
