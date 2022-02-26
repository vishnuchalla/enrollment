class Student < ApplicationRecord
  #has_many :enrolls, dependent: :destroy
  has_secure_password
    validates :Name, :presence => true
    validates :email, :presence => true
    validates :password_digest, :presence => true
    validates :date_of_birth, :presence => true
    validates :Phone_Number, :presence => true, length: {maximum:10}
    validates :Major, :presence => true
    validates :Student_ID, :presence => true
end
