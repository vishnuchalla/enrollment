class InstructorValidator<ActiveModel::Validator
  def validate(record)
    email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    record.errors.add :base, "invalid Student email format" unless record.email.match(email_regex)
  end
end

class Instructor < ApplicationRecord
  has_secure_password
    #has_many :courses
  validates :Name, :presence => true
  validates :email, :presence => true
  validates :password_digest, :presence => true
  validates :Department, :presence => true
  validates_with InstructorValidator
end
