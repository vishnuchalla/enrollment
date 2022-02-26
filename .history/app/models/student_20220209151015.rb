class GoodnessValidator < ActiveModel::Validator
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    if !Email.match(VALID_EMAIL_REGEX)
        record.errors.add :base, "invalid email"
    end
    


end

class Student < ApplicationRecord
    validates :Name, :presence => true
    validates :Email, :presence => true
    validates :Password, :presence => true
    validates :date_of_birth, :presence => true
    validates :Phone_Number, :presence => true
    validates :Major, :presence => true


end
