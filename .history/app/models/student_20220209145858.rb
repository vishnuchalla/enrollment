class Student < ApplicationRecord
    validates :Name, :presence => true
    validates :Email, :presence => true
    validates :Password, :presence => true
    validates :date_of_birth, :presence => true
    validates :Phone_Number, :presence => true
    validates :Major, :presence => true



end
