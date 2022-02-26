class Instructor < ApplicationRecord
  has_secure_password
    #has_many :courses
    validates :Name, :presence: true
    validates :email, :presence => true
    validates :password_digest, :presence => true
    validates :Department, :presence => true
    validates :password, confirmation: true
end
